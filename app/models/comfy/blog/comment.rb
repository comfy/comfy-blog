class Comfy::Blog::Comment < ActiveRecord::Base

  self.table_name = 'comfy_blog_comments'

  # -- Relationships --------------------------------------------------------
  belongs_to :post

  # -- Callbacks ------------------------------------------------------------
  before_create :set_is_published

  # -- Validations ----------------------------------------------------------
  validates :post_id, :content, :author, :email,
    :presence => true
  validates :email,
    :format => { :with => /\A([\w.%-+]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i }

  validate :check_commentable

  # -- Scopes ---------------------------------------------------------------
  scope :published, -> {
    where(:is_published => true)
  }

protected

  def set_is_published
    self.is_published = ComfyBlog.config.auto_publish_comments
    return
  end

  def check_commentable
    errors.add(:base, 'comments are not allowed') if post.try(:comments_disabled?)
  end
end