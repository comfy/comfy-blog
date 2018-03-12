# frozen_string_literal: true

class Comfy::Blog::Post < ActiveRecord::Base

  self.table_name = "comfy_blog_posts"

  include Comfy::Cms::WithFragments
  include Comfy::Cms::WithCategories

  cms_has_revisions_for :fragments_attributes

  # -- Relationships -----------------------------------------------------------
  belongs_to :site,
    class_name: "Comfy::Cms::Site"

  # -- Validations -------------------------------------------------------------
  validates :title, :slug, :year, :month,
    presence: true
  validates :slug,
    uniqueness: { scope: %i[site_id year month] },
    format:     { with: %r{\A%*\w[a-z0-9_%-]*\z}i }

  # -- Scopes ------------------------------------------------------------------
  scope :published, -> { where(is_published: true) }
  scope :for_year,  ->(year) { where(year: year) }
  scope :for_month, ->(month) { where(month: month) }

  # -- Callbacks ---------------------------------------------------------------
  before_validation :set_slug,
                    :set_published_at,
                    :set_date

  # -- Instance Mathods --------------------------------------------------------
  def url(relative: false)
    public_blog_path = ComfyBlog.config.public_blog_path
    post_path = ["/", public_blog_path, year, month, slug].join("/").squeeze("/")
    [site.url(relative: relative), post_path].join
  end

protected

  def set_slug
    self.slug ||= title.to_s.parameterize
  end

  def set_date
    self.year   = published_at.year
    self.month  = published_at.month
  end

  def set_published_at
    self.published_at ||= Time.zone.now
  end

end
