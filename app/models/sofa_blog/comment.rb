class SofaBlog::Comment < ActiveRecord::Base
  
  set_table_name :sofa_blog_comments
  
  # -- Relationships --------------------------------------------------------
  belongs_to :post,
    :counter_cache => :comments_count
    
  # -- Validations ----------------------------------------------------------
  validates :post_id, :presence => true
  validates :content, :name, :email, 
    :presence => true
  validates_length_of :email,
    :in         => 6..100,
    :too_short  => 'Your email address needs to be at least 6 characters long.'
  validates_format_of :email,
    :message    => 'The email you entered is not valid.',
    :with       => /^([\w.%-+]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i
    
  # -- Callbacks ------------------------------------------------------------
  after_save    :update_approved_comments_counter, :update_comments_counter
  after_destroy :update_approved_comments_counter, :update_comments_counter
    
  # -- Scopes ---------------------------------------------------------------
  scope :approved, where(:is_approved => true)
  
  # -- Instance Methods -----------------------------------------------------
  def approve!
    update_attribute(:is_approved, true)
  end
  
  def disapprove!
    update_attribute(:is_approved, false)
  end
  
protected
  def update_approved_comments_counter
    self.connection.execute("
      UPDATE sofa_blog_posts 
      SET approved_comments_count = #{post.comments.approved.count} 
      WHERE id = #{post.id}
    ")
  end
  
  def update_comments_counter
    self.connection.execute("
      UPDATE sofa_blog_posts
      SET comments_count = #{post.comments.count}
      WHERE id = #{post.id}
    ")
  end
  
end