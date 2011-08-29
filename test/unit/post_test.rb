require File.expand_path('../test_helper', File.dirname(__FILE__))

class PostTest < ActiveSupport::TestCase
  
  def test_fixtures_validity
    SofaBlog::Post.all.each do |post|
      assert post.valid?, post.errors.full_messages.to_s
    end
  end
  
  def test_validations
    flunk
  end
  
  def test_creation
    flunk
  end
  
end
