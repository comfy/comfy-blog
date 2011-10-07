class SofaBlog::Post < ActiveRecord::Base
  
  set_table_name :sofa_blog_posts

  # -- Attributes --------------------------------------------------------
  attr_accessor   :tag_names
  
  # -- Relationships --------------------------------------------------------
  has_many :comments, :dependent => :destroy
  has_many :taggings, :dependent => :destroy
  has_many :tags, :through => :taggings
  
  # -- Validations ----------------------------------------------------------
  validates :content, :presence => {:message => 'Please enter some content for this post'}
  validates :title, :presence => {:message => 'Please enter a title for this post'}
  
  # -- Scopes ---------------------------------------------------------------
  default_scope order('created_at DESC')
  scope :published, where(:is_published => true)
  scope :tagged_with, lambda { |tag_id|
    joins(:taggings).where('sofa_blog_taggings.tag_id' => tag_id)
  }
    
  # -- Callbacks ---------------------------------------------------------------
  before_save :assign_tags
  after_save :delete_unused_tags
    
  # -- Instance Methods -----------------------------------------------------
  def to_param
    "#{self.id}-#{title.downcase.gsub(/\W|_/, ' ').strip.squeeze(' ').gsub(/\s/, '-')}"
  end
  
  def tag_names
    @tag_names ||= self.tags.collect(&:name).join(', ')
  end


protected
  def self.collect_tags(query)
    return [] if query.blank?
    query.split(',').collect{|t| t.strip.downcase}.delete_if{|s|s.blank?}.uniq
  end

  def assign_tags
    self.tag_names # IMPORTANT: populating @tag_names so we can rebuild existing taggings
    self.taggings.delete_all

    SofaBlog::Post.collect_tags(self.tag_names).each do |tag_name|
      if existing_tag = SofaBlog::Tag.find_by_name(tag_name)
        self.tags << existing_tag
      else
        self.tags.new(:name => tag_name)
      end
    end
    @tag_names = nil # reloading the reader
  end

  def delete_unused_tags
    SofaBlog::Tag.destroy_all('taggings_count = 0')
  end

end