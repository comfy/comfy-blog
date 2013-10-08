require_relative '../../test_helper'

class BlogPostTest < ActiveSupport::TestCase
  
  def test_fixtures_validity
    Blog::Post.all.each do |post|
      assert post.valid?, post.errors.full_messages.to_s
    end
  end
  
end