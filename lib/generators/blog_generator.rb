class BlogGenerator < Rails::Generators::Base
  include Rails::Generators::Migration

  source_root File.expand_path('../../..', __FILE__) 
  
  def generate_migration
    destination   = File.expand_path('db/migrate/01_create_sofa_blog.rb', self.destination_root)
    migration_dir = File.dirname(destination)
    destination   = self.class.migration_exists?(migration_dir, 'create_sofa_blog')
  
    if destination
      puts "\e[0m\e[31mFound existing create_sofa_blog.rb migration. Remove it if you want to regenerate.\e[0m"
    else
      migration_template 'db/migrate/01_create_sofa_blog.rb', 'db/migrate/create_sofa_blog.rb'
    end
  end
  
  def generate_public_assets
    directory 'public/javascripts/', 'public/javascripts/comfortable_mexican_sofa/blog'
    directory 'public/stylesheets/', 'public/stylesheets/comfortable_mexican_sofa/blog'
  end
  
  
  def show_readme
    readme 'lib/generators/README'
  end
  
  def self.next_migration_number(dirname)
    orm = Rails.configuration.generators.options[:rails][:orm]
    require "rails/generators/#{orm}"
    "#{orm.to_s.camelize}::Generators::Base".constantize.next_migration_number(dirname)
  end
end
