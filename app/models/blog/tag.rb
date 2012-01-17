class Blog::Tag < ActiveRecord::Base

  set_table_name :blog_tags

  # -- Relationships --------------------------------------------------------
  has_many :taggings, :dependent => :destroy
  has_many :posts, :through => :taggings
    
  # -- Validations ----------------------------------------------------------
  validates_uniqueness_of :name
  
  # -- Callbacks ---------------------------------------------------------
  before_validation :strip_name
  
protected

  def strip_name
    self.name.strip!
  end
  
end
