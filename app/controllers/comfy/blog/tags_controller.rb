class Comfy::Blog::TagsController < Comfy::Blog::BaseController

  def create
    @tag.save!
  end
end
