class Comfy::Blog::Blog < ActiveRecord::Base

  self.table_name = 'comfy_blogs'

  # -- Relationhips ------------------------------------------------------------
  belongs_to :site,
    class_name: 'Comfy::Cms::Site'

  has_many :posts,
    dependent: :destroy

  # -- Callbacks ---------------------------------------------------------------
  before_validation :clean_path

  # -- Validations -------------------------------------------------------------
  validates :label, :identifier,
    presence: true
  validates :identifier,
    format: {with: /\A\w[a-z0-9_-]*\z/i}
  validates :path,
    uniqueness: {scope: :site_id}
  validates :path,
    format:     {with: /\A\w[a-z0-9_-]*\z/i},
    allow_blank: true

protected

  def clean_path
    self.path = nil if self.path.blank?
  end
end
