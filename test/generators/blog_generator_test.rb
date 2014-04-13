require_relative '../test_helper'
require_relative '../../lib/generators/comfy/blog/blog_generator'

class CmsGeneratorTest < Rails::Generators::TestCase
  tests Comfy::Generators::BlogGenerator
  
  def test_generator
    run_generator
    
    assert_migration 'db/migrate/create_blog.rb'
    
    assert_file 'config/initializers/comfy_blog.rb'
    
    assert_file 'config/routes.rb', read_file('blog/routes.rb')
    
    assert_directory 'app/views/comfy/blog'
  end
  
end