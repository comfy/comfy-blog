class Comfy::Blog::Post < ActiveRecord::Base

  self.table_name = 'comfy_blog_posts'

  # -- Relationships --------------------------------------------------------
  belongs_to :blog

  has_many :comments,
    :dependent => :destroy

  has_many :taggings
  has_many :tags, through: :taggings

  # -- Validations ----------------------------------------------------------
  validates :blog_id, :title, :slug, :year, :month, :content, :tag_list,
    :presence   => true
  validates :slug,
    :uniqueness => { :scope => [:blog_id, :year, :month] },
    :format => { :with => /\A%*\w[a-z0-9_\-\%]*\z/i }

  # -- Scopes ---------------------------------------------------------------
  default_scope -> {
    order('published_at DESC')
  }
  scope :published, -> {
    where(:is_published => true)
  }
  scope :for_year, -> year {
    where(:year => year)
  }
  scope :for_month, -> month {
    where(:month => month)
  }

  # -- Callbacks ------------------------------------------------------------
  before_validation :set_slug,
                    :set_published_at,
                    :set_date

  def tag_list
    tags.map(&:name).join(', ')
  end

protected

  def self.tagged_with(name)
    Tag.find_by_name!(name).posts
  end

  def tag_list=(names)
    self.tags = names.split(", ").map do |n|
      Tag.where(name: n.strip).first_or_create!
    end
  end

  def set_slug
    self.slug ||= self.title.to_s.downcase.slugify
  end

  def set_date
    self.year   = self.published_at.year
    self.month  = self.published_at.month
  end

  def set_published_at
    self.published_at ||= Time.zone.now
  end

end
