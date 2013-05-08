class Blog::Post < ActiveRecord::Base

  attr_accessible :title, :slug, :author, :tag_names, :excerpt, :content, :published_at, :is_published, :category_ids

  self.table_name = :blog_posts

  # -- Attributes -----------------------------------------------------------
  attr_accessor :tag_names,
                :category_ids
  
  # -- Relationships --------------------------------------------------------
  has_many :comments, :dependent => :destroy
  has_many :taggings, :dependent => :destroy
  has_many :tags, :through => :taggings
  
  # -- Validations ----------------------------------------------------------
  validates :title, :slug, :year, :month, :content,
    :presence   => true
  validates :slug,
    :uniqueness => { :scope => [:year, :month] }
  
  # -- Scopes ---------------------------------------------------------------
  default_scope order('published_at DESC')
  
  scope :published, where(:is_published => true)
  scope :for_year, lambda { |year| 
    where(:year => year) 
  }
  scope :for_month, lambda { |month|
    where(:month => month)
  }
  scope :tagged_with, lambda { |tag|
    joins(:tags).where('blog_tags.name' => tag, 'blog_tags.is_category' => false)
  }
  scope :categorized_as, lambda { |tag|
    joins(:tags).where('blog_tags.name' => tag, 'blog_tags.is_category' => true)
  }
  
  # -- Callbacks ------------------------------------------------------------
  before_validation :set_slug,
                    :set_published_at,
                    :set_date
  after_save        :sync_tags,
                    :sync_categories
  
  # -- Instance Methods -----------------------------------------------------
  def tag_names(reload = false)
    @tag_names = nil if reload
    @tag_names ||= self.tags.tags.collect(&:name).join(', ')
  end
  
  def category_ids
    @category_ids ||= self.tags.categories.inject({}){|h, c| h[c.id.to_s] = '1'; h}
  end
  
protected
  
  def set_slug
    self.slug ||= self.title.to_s.slugify
  end
  
  def set_date
    self.year   = self.published_at.year
    self.month  = self.published_at.month
  end
  
  def set_published_at
    self.published_at ||= Time.zone.now
  end
  
  def sync_tags
    return unless tag_names
    self.taggings.for_tags.destroy_all
    self.tag_names.split(',').map{ |t| t.strip }.uniq.each do |tag_name|
      self.tags << Blog::Tag.find_or_create_by_name(tag_name) rescue nil
    end
  end
  
  def sync_categories
    self.category_ids.each do |category_id, flag|
      case flag.to_i
      when 1
        if category = Blog::Tag.categories.find_by_id(category_id)
          category.taggings.create(:post => self) rescue nil
        end
      when 0
        self.taggings.for_categories.where(:tag_id => category_id).destroy_all
      end
    end
  end
  
end