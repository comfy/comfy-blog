# ComfyBlog
[![Gem Version](https://img.shields.io/gem/v/comfy_blog.svg?style=flat)](http://rubygems.org/gems/comfy_blog) [![Gem Downloads](https://img.shields.io/gem/dt/comfy_blog.svg?style=flat)](http://rubygems.org/gems/comfy_blog) [![Build Status](https://img.shields.io/travis/comfy/comfy-blog.svg?style=flat)](https://travis-ci.org/comfy/comfy-blog) [![Dependency Status](https://img.shields.io/gemnasium/comfy/comfy-blog.svg?style=flat)](https://gemnasium.com/comfy/comfy-blog) [![Code Climate](https://img.shields.io/codeclimate/github/comfy/comfy-blog.svg?style=flat)](https://codeclimate.com/github/comfy/comfy-blog) [![Coverage Status](https://img.shields.io/coveralls/comfy/comfy-blog.svg?style=flat)](https://coveralls.io/r/comfy/comfy-blog?branch=master)

ComfyBlog is a simple blog management engine for [ComfortableMexicanSofa](https://github.com/comfy/comfortable-mexican-sofa)

## !!! NOTE !!!

THis is master branch that only works with currently unreleased version 2.0 of CMS and Rails 5.2

If you want to use it with bleeding-edge Rails, add this to your Gemfile:

```ruby
gem "rails",
  github: "rails/rails"
gem "arel",
  github: "rails/arel"

# There's no gem published for Bootstrap4 just yet
gem "bootstrap_form",
  github: "bootstrap-ruby/rails-bootstrap-forms",
  branch: "bootstrap-v4"

gem "comfortable_mexican_sofa",
  github: "comfy/comfortable-mexican-sofa"
gem "comfy_blog",
  github: "comfy/comfy-blog"
```

## Features

* Ability to set up multiple blogs per site
* User defined layout per blog

## Installation

Add gem definition to your Gemfile:

```ruby
gem 'comfy_blog', '~> 1.12.0'
```

Then from the Rails project's root run:

    bundle install
    rails generate comfy:blog
    rake db:migrate

Take a look inside your `config/routes.rb` file and you should see following lines there:

```ruby
comfy_route :blog_admin, :path => 'admin'
comfy_route :blog, :path => 'blog'
```

You should also find view templates in `/app/views/blog` folder. Feel free to adjust them as you see fit.

---

Copyright 2009-2017 Oleg Khabarov
