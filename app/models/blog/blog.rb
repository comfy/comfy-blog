class Blog::Blog < ActiveRecord::Base
  
  # -- Relationhips ---------------------------------------------------------
  belongs_to :site, :class_name => 'Cms::Site'
  
  has_many :posts,
    :dependent  => :destroy
  has_many :comments,
    :through    => :posts
    
  # -- Validations ----------------------------------------------------------
  validates :site_id, :label, :identifier,
    :presence   => true
  validates :identifier,
    :format     => { :with => /\A\w[a-z0-9_-]*\z/i }
  validates :path,
    :uniqueness => { :scope => :site_id },
    :format     => { :with => /\A\w[a-z0-9_-]*\z/i },
    :presence   => true,
    :if         => 'restricted_path?'
  
protected

  def restricted_path?
    (self.class.count > 1 && self.persisted?) ||
    (self.class.count >= 1 && self.new_record?)
  end

end