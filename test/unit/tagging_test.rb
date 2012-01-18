require File.expand_path('../test_helper', File.dirname(__FILE__))

class TaggingTest < ActiveSupport::TestCase
  
  def test_fixtures_validity
    Blog::Tagging.all.each do |tagging|
      assert tagging.valid?, tagging.errors.to_s
    end
  end
  
  def test_destroy_for_tag
    assert_difference ['Blog::Tagging.count', 'Blog::Tag.count'], -1 do
      blog_taggings(:tag).destroy
    end
  end
    
  def test_destroy_for_category
    assert_difference 'Blog::Tagging.count', -1 do
      assert_no_difference 'Blog::Tag.count' do
        blog_taggings(:category).destroy
      end
    end
  end
  
  def test_scopes
    assert_equal 1, Blog::Tagging.for_tags.count
    assert_equal 1, Blog::Tagging.for_categories.count
  end
  
end
