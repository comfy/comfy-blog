# frozen_string_literal: true

require "rails/generators/active_record"

module Comfy
  module Generators
    class BlogGenerator < Rails::Generators::Base

      include Rails::Generators::Migration
      include Thor::Actions

      source_root File.expand_path("../../../..", __dir__)

      def self.next_migration_number(dirname)
        ActiveRecord::Generators::Base.next_migration_number(dirname)
      end

      def generate_migration
        migrations = %w[
          01_create_blog
          02_add_file_reference_to_blog_posts
        ]
        version_regex = %r{\d.*?_}

        migrations.each do |identifier|
          destination = File.expand_path(
            "db/migrate/#{identifier}.rb", destination_root
          )
          migration_dir = File.dirname(destination)
          destination   = self.class.migration_exists?(
            migration_dir, identifier.gsub(version_regex, "")
          )

          if destination
            puts "\e[0m\e[31mFound existing #{identifier
              .gsub(version_regex, '')} migration. Remove it \
              if you want to regenerate.\e[0m"
          else
            migration_template "db/migrate/#{identifier}.rb",
              "db/migrate/#{identifier.gsub(version_regex, '')}.rb"
          end
        end
      end

      def generate_initialization
        copy_file "config/initializers/comfy_blog.rb",
          "config/initializers/comfy_blog.rb"
      end

      def generate_routing
        route_string = <<-RUBY.strip_heredoc
          comfy_route :blog_admin, path: "/admin"
          comfy_route :blog, path: "/blog"
        RUBY
        route route_string
      end

      def generate_views
        directory "app/views/comfy/blog", "app/views/comfy/blog"
      end

      def show_readme
        readme "lib/generators/comfy/blog/README"
      end

    end
  end
end
