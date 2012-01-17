require File.expand_path('../test_helper', File.dirname(__FILE__))

class SofaBlog::TagTest < ActiveSupport::TestCase
  
  def test_fixtures_validity
    Blog::Tag.all.each do |tag|
      assert tag.valid?, tag.errors.to_s
    end
  end
  
  def test_validation
    old_tag = blog_tags(:default)
    tag = Blog::Tag.new(:name => old_tag.name)
    assert tag.invalid?
    assert_has_errors_on tag, [:name]
  end
  
  def test_strip_name
    tag = Blog::Tag.new(:name => ' Test Tag ')
    assert tag.valid?
    assert_equal 'Test Tag', tag.name
  end
  
  def test_creation
    assert_difference 'Blog::Tag.count' do
      tag = Blog::Tag.create(:name => 'Test Tag')
    end
  end
  
  def test_destroy
    assert_difference ['Blog::Tag.count', 'Blog::Tagging.count'], -1 do
      blog_tags(:default).destroy
    end
  end
  
end
