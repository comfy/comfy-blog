class Blog::Tag < ActiveRecord::Base

  attr_accessible :name, :is_category

  self.table_name = :blog_tags

  # -- Relationships --------------------------------------------------------
  has_many :taggings, :dependent => :destroy
  has_many :posts, :through => :taggings
    
  # -- Validations ----------------------------------------------------------
  validates_uniqueness_of :name, :case_sensitive => false
  
  # -- Callbacks ------------------------------------------------------------
  before_validation :strip_name
  
  # -- Scopes ---------------------------------------------------------------
  scope :categories,  where(:is_category => true)
  scope :tags,        where(:is_category => false)
  
protected
  
  def strip_name
    self.name = self.name.strip if self.name
  end
  
end
