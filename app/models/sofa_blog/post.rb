class SofaBlog::Post < ActiveRecord::Base
  
  set_table_name :sofa_blog_posts
  
  # -- Relationships --------------------------------------------------------
  has_many :comments, :dependent => :destroy
  
  # -- Validations ----------------------------------------------------------
  validates_presence_of :title, :content
  
  # -- Scopes ---------------------------------------------------------------
  default_scope order('created_at DESC')
  scope :published, where(:is_published => true)
    
  # -- Instance Methods -----------------------------------------------------
  def to_param
    "#{self.id}-#{title.downcase.gsub(/\W|_/, ' ').strip.squeeze(' ').gsub(/\s/, '-')}"
  end
  
end