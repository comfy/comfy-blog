require File.expand_path('../test_helper', File.dirname(__FILE__))

class SofaBlog::TaggingTest < ActiveSupport::TestCase
  
  def test_fixtures_validity
    Blog::Tagging.all.each do |tagging|
      assert tagging.valid?, tagging.errors.to_s
    end
  end
  
  def test_destroy
    assert_difference ['Blog::Tagging.count', 'Blog::Tag.count'], -1 do
      blog_taggings(:default).destroy
    end
  end
  
end
