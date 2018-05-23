# ComfyBlog

ComfyBlog is a simple blog management engine for [ComfortableMexicanSofa](https://github.com/comfy/comfortable-mexican-sofa)

[![Gem Version](https://img.shields.io/gem/v/comfy_blog.svg?style=flat)](http://rubygems.org/gems/comfy_blog)
[![Gem Downloads](https://img.shields.io/gem/dt/comfy_blog.svg?style=flat)](http://rubygems.org/gems/comfy_blog)
[![Build Status](https://img.shields.io/travis/comfy/comfy-blog.svg?style=flat)](https://travis-ci.org/comfy/comfy-blog)
[![Coverage Status](https://img.shields.io/coveralls/comfy/comfy-blog.svg?style=flat)](https://coveralls.io/r/comfy/comfy-blog?branch=master)
[![Gitter](https://badges.gitter.im/comfy/comfortable-mexican-sofa.svg)](https://gitter.im/comfy/comfortable-mexican-sofa)

## Dependencies

Make sure that you have [ComfortableMexicanSofa](https://github.com/comfy/comfortable-mexican-sofa) installed first.

## Installation

Add gem definition to your Gemfile:

```ruby
gem "comfy_blog", "~> 2.0.0"
```

Then from the Rails project's root run:

    bundle install
    rails generate comfy:blog
    rake db:migrate

Take a look inside your `config/routes.rb` file and you should see following lines there:

```ruby
comfy_route :blog_admin, path: "admin"
comfy_route :blog, path: "blog"
```

You should also find view templates in `/app/views/blog` folder. Feel free to adjust them as you see fit.

![Admin Area Preview](/doc/preview.jpg)

---

Copyright 2009-2018 Oleg Khabarov
