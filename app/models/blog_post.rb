class BlogPost < ActiveRecord::Base
  
  attr_accessor   :tag_names
  
  # -- Relationships --------------------------------------------------------
  
  has_many :blog_comments, :dependent => :destroy
  has_many :blog_taggings, :dependent => :destroy
  has_many :blog_tags, :through => :blog_taggings
  
  # -- Validations ----------------------------------------------------------
  
  validates :content, :presence => {:message => 'Please enter some content for this post'}
  validates :title, :presence => {:message => 'Please enter a title for this post'}
  
  # -- Scopes ----------------------------------------------------------

  scope :published, where(:published => true).order('created_at DESC')
  scope :tagged_with, lambda { |tag_id|
    joins(:blog_taggings).where('blog_taggings.blog_tag_id' => tag_id)
  }
  
  # -- AR Callbacks ---------------------------------------------------------
  
  before_save :assign_tags
  after_save :delete_unused_tags
  
  # -- Instance Methods --------------------------------------------------------
  
  def to_param
    "#{self.id}-#{title.downcase.gsub(/\W|_/, ' ').strip.squeeze(' ').gsub(/\s/, '-')}"
  end
  
  def tag_names
    @tag_names ||= self.blog_tags.collect(&:name).join(', ')
  end
  

protected
  def self.collect_tags(query)
    return [] if query.blank?
    query.split(',').collect{|t| t.strip.downcase}.delete_if{|s|s.blank?}.uniq
  end

  def assign_tags
    self.tag_names # IMPORTANT: populating @tag_names so we can rebuild existing taggings
    self.blog_taggings.delete_all

    BlogPost.collect_tags(self.tag_names).each do |tag_name|
      if existing_tag = BlogTag.find_by_name(tag_name)
        self.blog_tags << existing_tag
      else
        self.blog_tags.new(:name => tag_name)
      end
    end
    @tag_names = nil # reloading the reader
  end

  def delete_unused_tags
    BlogTag.destroy_all('blog_taggings_count = 0')
  end
end
