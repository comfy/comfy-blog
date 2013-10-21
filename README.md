# ComfyBlog 
[![Gem Version](https://badge.fury.io/rb/comfy_blog.png)](http://rubygems.org/gems/comfy_blog) [![Build Status](https://secure.travis-ci.org/comfy/comfy-blog.png)](http://travis-ci.org/comfy/comfy-blog) [![Dependency Status](https://gemnasium.com/comfy/comfy-blog.png)](https://gemnasium.com/comfy/comfy-blog) [![Code Climate](https://codeclimate.com/github/comfy/comfy_blog.png)](https://codeclimate.com/github/comfy/comfy-blog) [![Coverage Status](https://coveralls.io/repos/comfy/comfy_blog/badge.png?branch=master)](https://coveralls.io/r/comfy/comfy-blog)

ComfyBlog is an simple blog management engine for [ComfortableMexicanSofa](https://github.com/comfy/comfortable-mexican-sofa) CMS Engine.

## Features

* Ability to set up multiple blogs per site
* User defined layout per blog

## Installation

Add gem definition to your Gemfile:

```ruby
gem 'comfy_blog', '~> 1.0.0'
```

Then from the Rails project's root run:
    
    bundle install
    rails generate comfy:blog
    rake db:migrate
    
Take a look inside your `config/routes.rb` file and you should see following lines there:

```ruby
ComfyBlog::Routing.admin   :path => 'admin'
ComfyBlog::Routing.content :path => 'blog'
```

You should also find view templates in `/app/views/blog` folder. Feel free to adjust them as you see fit.

---

Copyright 2009-2013 Oleg Khabarov, [The Working Group Inc](http://www.twg.ca)