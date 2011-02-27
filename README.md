Sofa Blog
===================================

Sofa Blog is an extension for [ComfortableMexicanSofa](https://github.com/twg/comfortable-mexican-sofa) (CMS) that allows management of blog posts and comments.

Installation
------------
Add gem definition to your Gemfile:
    
    gem 'sofa_blog'
    
Then from the Rails project's root run:
    
    bundle install
    rails g blog
    rake db:migrate
    
Usage
-----
After finishing installation you should be able to navigate to the CMS admin area (http://yoursite/cms-admin by default) and see a Blog Posts tab on the main navigation.

    
Dependencies
-----------------
Sofa Blog depends on:

* **[ComfortableMexicanSofa](https://github.com/twg/comfortable-mexican-sofa)** - A tiny and powerful micro CMS for your Rails 3 application

* * *

![Looks pretty comfortable to me. No idea what makes it Mexican.](https://github.com/twg/sofa-blog/raw/master/doc/sofa.png)

Sofa Blog is released under the [MIT license](https://github.com/twg/sofa-blog/raw/master/LICENSE) 

Copyright 2011 Jack Neto, [The Working Group Inc](http://www.twg.ca)