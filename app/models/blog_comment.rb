class BlogComment < ActiveRecord::Base
  
  # -- Relationships --------------------------------------------------------
  
  belongs_to :blog_post, :counter_cache => :comments_count
  
  # -- Validations ----------------------------------------------------------
  
  validates_presence_of   :content
  validates_length_of :email,
    :in         => 6..100,
    :too_short  => 'Your email address needs to be at least 6 characters long.'
  validates_format_of :email,
    :message    => 'The email you entered is not valid.',
    :with       => /^([\w.%-+]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i
  
  # -- Scopes ----------------------------------------------------------

  scope :approved, :conditions => {:approved => true }
  
  # -- AR Callbacks ---------------------------------------------------------
  
  after_save :update_approved_comments_counter, :update_comments_counter
  after_destroy :update_approved_comments_counter, :update_comments_counter
  
  # -- Instance Methods --------------------------------------------------------
  
  def approve!
    update_attribute(:approved, true)
  end
  
  def disapprove!
    update_attribute(:approved, false)
  end
  
  
protected
  def update_approved_comments_counter
    self.connection.execute("UPDATE blog_posts SET approved_comments_count = #{blog_post.blog_comments.approved.count} WHERE id = #{blog_post.id}")
  end

  def update_comments_counter
    self.connection.execute("UPDATE blog_posts SET comments_count = #{blog_post.blog_comments.count} WHERE id = #{blog_post.id}")
  end
end
