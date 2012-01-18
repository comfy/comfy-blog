class BlogGenerator < Rails::Generators::Base
  require 'rails/generators/active_record'
  include Rails::Generators::Migration
  include Thor::Actions

  source_root File.expand_path('../../..', __FILE__) 
  
  def generate_migration
    destination   = File.expand_path('db/migrate/01_create_sofa_blog.rb', self.destination_root)
    migration_dir = File.dirname(destination)
    destination   = self.class.migration_exists?(migration_dir, 'create_sofa_blog')
  
    if destination
      puts "\e[0m\e[31mFound existing create_sofa_blog.rb migration. Remove it if you want to regenerate.\e[0m"
    else
      migration_template 'db/migrate/01_create_comfy_blog.rb', 'db/migrate/create_comfy_blog.rb'
    end
  end
  
  def generate_initialization
    copy_file 'config/initializers/comfy_blog.rb', 'config/initializers/comfy_blog.rb'
  end
  
  def show_readme
    readme 'lib/generators/README'
  end
  
  def self.next_migration_number(dirname)
    ActiveRecord::Generators::Base.next_migration_number(dirname)
  end
end