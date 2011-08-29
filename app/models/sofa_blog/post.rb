class SofaBlog::Post < ActiveRecord::Base
  
  set_table_name :sofa_blog_posts
  
  # -- Relationships --------------------------------------------------------
  has_many :comments, :dependent => :destroy
  
  # -- Validations ----------------------------------------------------------
  validates_presence_of :title, :content
  
  # -- Scopes ---------------------------------------------------------------
  scope :published, 
    where(:published => true).order('created_at DESC')
    
  # -- Instance Methods -----------------------------------------------------
  def to_param
    "#{self.id}-#{title.downcase.gsub(/\W|_/, ' ').strip.squeeze(' ').gsub(/\s/, '-')}"
  end
  
end