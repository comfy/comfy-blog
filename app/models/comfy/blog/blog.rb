class Comfy::Blog::Blog < ActiveRecord::Base
  
  self.table_name = 'comfy_blogs'
  
  # -- Relationhips ---------------------------------------------------------
  belongs_to :site, :class_name => 'Comfy::Cms::Site'
  
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

  # Returns a hash where key is a tuple [year, month] and the value stands for number
  # of posts published within that period.
  #
  # blog.archival_entries
  # => { [2015, 7] => 3, [2015, 6] => 1 }
  def archival_entries
    posts.published.group([:year, :month]).reorder(year: :desc, month: :desc).count
  end
  
protected

  def restricted_path?
    (self.class.count > 1 && self.persisted?) ||
    (self.class.count >= 1 && self.new_record?)
  end

end