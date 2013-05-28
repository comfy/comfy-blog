class Blog::Tagging < ActiveRecord::Base

  attr_accessible :post

  self.table_name = :blog_taggings
  
  # -- Relationships --------------------------------------------------------
  belongs_to :post
  belongs_to :tag, :counter_cache => true
  
  # -- Callbacks ------------------------------------------------------------
  after_destroy :destroy_tag
  
  # -- Scopes ---------------------------------------------------------------
  scope :for_tags,        includes(:tag).where('blog_tags.is_category' => false)
  scope :for_categories,  includes(:tag).where('blog_tags.is_category' => true)
  
protected
  
  def destroy_tag
    self.tag.destroy if !self.tag.is_category? && self.tag.taggings.count == 0
  end
  
end
