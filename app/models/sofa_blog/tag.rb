class SofaBlog::Tag < ActiveRecord::Base

  set_table_name :sofa_blog_tags

  # -- Relationships --------------------------------------------------------
  has_many :taggings, :dependent => :destroy
  has_many :posts, :through => :taggings

  # -- Validations ----------------------------------------------------------
  validates_uniqueness_of :name
  
  # -- Callbacks ---------------------------------------------------------
  before_validation :downcase_name
  
  
  
protected

  def downcase_name
    self.name = self.name.downcase unless self.name.blank?
  end
  
end
