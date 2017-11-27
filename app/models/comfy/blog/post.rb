class Comfy::Blog::Post < ActiveRecord::Base

  self.table_name = 'comfy_blog_posts'

  include Comfy::Cms::WithFragments
  include Comfy::Cms::WithCategories

  # -- Relationships -----------------------------------------------------------
  belongs_to :blog

  # -- Validations -------------------------------------------------------------
  validates :title, :slug, :year, :month,
    presence: true
  validates :slug,
    uniqueness: {scope: [:blog_id, :year, :month]},
    format:     {with: /\A%*\w[a-z0-9_\-\%]*\z/i }

  # -- Scopes ------------------------------------------------------------------
  scope :published, -> {
    where(is_published: true)
  }
  scope :for_year, -> year {
    where(year: year)
  }
  scope :for_month, -> month {
    where(month: month)
  }

  # -- Callbacks ---------------------------------------------------------------
  before_validation :set_slug,
                    :set_published_at,
                    :set_date

protected

  def set_slug
    self.slug ||= self.title.to_s.parameterize
  end

  def set_date
    self.year   = self.published_at.year
    self.month  = self.published_at.month
  end

  def set_published_at
    self.published_at ||= Time.zone.now
  end
end
