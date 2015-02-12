require_relative '../test_helper'

class BlogTagsTest < ActiveSupport::TestCase

  def test_fixture_validity
    Comfy::Blog::Tag.all.each do |tag|
      assert tag.valid?, tag.errors.full_messages.to_s
    end
  end

  def test_creation
    assert_difference ['Comfy::Blog::Tag.count', 'Comfy::Blog::Tagging.count'], +1 do
      tag = comfy_blog_posts(:default).tags.create!(
        :name => 'Tag 1!'
      )
    end
  end

  def test_destroy
    assert_difference 'Comfy::Blog::Tag.count', -1 do
      comfy_blog_tags(:default).destroy
    end
  end
end
