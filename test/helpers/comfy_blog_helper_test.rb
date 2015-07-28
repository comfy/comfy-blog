require_relative '../test_helper'

class ComfyBlogHelperTest < ActionView::TestCase
  include Comfy::BlogHelper

  def test_comfy_blog_friendly_date
    assert_equal "2013",          comfy_blog_friendly_date(2013, 0)
    assert_equal "January 2013",  comfy_blog_friendly_date(2013, "1")
    assert_equal "November 2013", comfy_blog_friendly_date(2013, "11")
    assert_equal "December 1986", comfy_blog_friendly_date(1986, "12")
    assert_equal "2013",          comfy_blog_friendly_date(2013, 13)

    I18n.with_locale(:pl) do
      assert_equal "listopad 2013", comfy_blog_friendly_date(2013, 11)
      assert_equal "luty 1986",     comfy_blog_friendly_date(1986, "2")
    end
  end

  def test_comfy_blog_friendly_date_for_weird_input
    assert_equal "",  comfy_blog_friendly_date(nil, nil)
    assert_equal "",  comfy_blog_friendly_date("", "")
    assert_equal "0", comfy_blog_friendly_date(0, 0)
  end

end
