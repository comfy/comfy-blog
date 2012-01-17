class Blog::Comment < ActiveRecord::Base
  
  set_table_name :blog_comments
  
  attr_accessible :author,
                  :email,
                  :content
  
  # -- Relationships --------------------------------------------------------
  belongs_to :post
    
  # -- Validations ----------------------------------------------------------
  validates :post_id, :content, :author, :email, 
    :presence => true
  validates :email,
    :format => { :with => /^([\w.%-+]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i }
    
  # -- Scopes ---------------------------------------------------------------
  scope :published, where(:is_published => true)
  
end