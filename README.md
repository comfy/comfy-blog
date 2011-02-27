# Sofa Blog

Sofa Blog is an extension for [ComfortableMexicanSofa](https://github.com/twg/comfortable-mexican-sofa) (CMS) that allows management of blog posts and comments.

## Installation

Add gem definition to your Gemfile:
    
    gem 'sofa_blog'
    
Then from the Rails project's root run:
    
    bundle install
    rails g blog
    rake db:migrate
    
## Usage

After finishing installation you should be able to navigate to the CMS admin area (http://yoursite/cms-admin by default) and see a Blog Posts tab on the main navigation.

### The Blog Post
  
    @post = BlogPost.first          # Grab the first post
    @post.title                     # The title of the post
    @post.author                    # The name of the author
    @post.content                   # The content of the post
    @post.published?                # Returns true if the post has been published
    @post.created_at                # Created at
    @post.updated_at                # Updated at
    @post.comments_count            # The total number of comments
    @post.approved_comments_count   # The number of approved comments
    
A blog post can be tagged with a comma separared list of words.

    @post.blog_tags.collect(&:name).join(', ') # Returns a comma-separated list of tags in the post
  
  
A few scopes are also available for your convenience:

    BlogPost.published                                    # All the published posts 
    BlogPost.tagged_with(params[:tag_id].to_i)            # All the posts tagged with a specific tag_id
    BlogPost.published.tagged_with(params[:tag_id].to_i)  # All the published posts tagged with a specific tag_id
   
### The Comments
  
    @comment = @post.blog_comments.first   # Grab the first comment
    @comment.name                          # The name of the author
    @comment.email                         # The email of the author
    @comment.content                       # The comment
    @comment.created_at                    # Created at
    @comment.updated_at                    # Updated at

    
## Dependencies

Sofa Blog depends on:

* **[ComfortableMexicanSofa](https://github.com/twg/comfortable-mexican-sofa)** - A tiny and powerful micro CMS for your Rails 3 application

* * *

![Looks pretty comfortable to me. No idea what makes it Mexican.](https://github.com/twg/sofa-blog/raw/master/doc/sofa.png)

Sofa Blog is released under the [MIT license](https://github.com/twg/sofa-blog/raw/master/LICENSE) 

Copyright 2011 Jack Neto, [The Working Group Inc](http://www.twg.ca)