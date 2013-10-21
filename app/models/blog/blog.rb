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

end