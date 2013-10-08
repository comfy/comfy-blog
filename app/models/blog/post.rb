class Blog::Post < ActiveRecord::Base
  
  cms_is_categorized
  
  self.table_name = 'blog_posts'

  # -- Attributes -----------------------------------------------------------
  attr_accessor :tag_names,
                :category_ids
  
  # -- Relationships --------------------------------------------------------
  belongs_to :site, 
    :class_name => 'Cms::Site'
  has_many :comments,
    :dependent => :destroy
  
  # -- Validations ----------------------------------------------------------
  validates :site_id,
    :presence   => true
  validates :title, :slug, :year, :month, :content,
    :presence   => true
  validates :slug,
    :uniqueness => { :scope => [:site_id, :year, :month] },
    :format     => { :with => /\A\w[a-z0-9_-]*\z/i }
  
  # -- Scopes ---------------------------------------------------------------
  default_scope -> {
    order('published_at DESC')
  }
  scope :published, -> {
    where(:is_published => true)
  }
  scope :for_year, -> year {
    where(:year => year) 
  }
  scope :for_month, -> month {
    where(:month => month)
  }
  
  # -- Callbacks ------------------------------------------------------------
  before_validation :set_slug,
                    :set_published_at,
                    :set_date
  
protected
  
  def set_slug
    self.slug ||= self.title.to_s.downcase.slugify
  end
  
  def set_date
    self.year   = self.published_at.year
    self.month  = self.published_at.month
  end
  
  def set_published_at
    self.published_at ||= Time.zone.now
  end
  
end