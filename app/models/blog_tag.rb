class BlogTag < ActiveRecord::Base
  
  # -- AR Callbacks ---------------------------------------------------------

  before_validation :downcase_name
  
  # -- Validations ----------------------------------------------------------

  validates_uniqueness_of :name
  
  # -- Relationships --------------------------------------------------------

  has_many :blog_taggings, :dependent => :destroy
  has_many :blog_posts, :through => :blog_taggings
  
protected

  def downcase_name
    self.name = self.name.downcase unless self.name.blank?
  end
  
end
