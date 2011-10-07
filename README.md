# Sofa Blog

Sofa Blog is an simple blog management engine for Rails 3.1 apps. As a bonus it integrates seamlessly with [ComfortableMexicanSofa](https://github.com/twg/comfortable-mexican-sofa) (microCMS)   

---
## Installation

Add gem definition to your Gemfile:
    
    gem 'sofa_blog'
    
Then from the Rails project's root run:
    
    bundle install
    rails g blog
    rake db:migrate
    
You can immediately access it by going to 

    /posts
    /admin/posts


---

## Usage

If you are using SofaBlog on it's own take a look in the initializer: `/config/initializers/sofa_blog.rb`. You probably want to set the admin controller to be something that handles user authentication within your app. Same goes for the `admin_route_prefix`.

If you are using SofaBlog in conjunction with ComfortableMexicanSofa everything will be configured automatically.

### The Blog Post
  
    @post = SofaBlog::Post.first    # Grab the first post
    @post.title                     # The title of the post
    @post.author                    # The name of the author
    @post.content                   # The content of the post
    @post.is_published?             # Returns true if the post has been published
    @post.created_at                # Created at
    @post.updated_at                # Updated at
    @post.comments_count            # The total number of comments
    @post.approved_comments_count   # The number of approved comments
    
A blog post can be tagged with a comma separared list of words.

    @post.tags.collect(&:name).join(', ') # Returns a comma-separated list of tags in the post
  
  
A few scopes are also available for your convenience:

    SofaBlog::Post.published                                    # All the published posts 
    SofaBlog::Post.tagged_with(params[:tag_id].to_i)            # All the posts tagged with a specific tag_id
    SofaBlog::Post.published.tagged_with(params[:tag_id].to_i)  # All the published posts tagged with a specific tag_id
   
### The Comments
  
    @comment = @post.comments.first   # Grab the first comment
    @comment.name                     # The name of the author
    @comment.email                    # The email of the author
    @comment.content                  # The comment
    @comment.is_approved?             # Returns true if the comment has been approved
    @comment.created_at               # Created at
    @comment.updated_at               # Updated at
    
    
* * *

Sofa Blog is released under the [MIT license](https://github.com/twg/sofa-blog/raw/master/LICENSE) 

Copyright 2011 Jack Neto, [The Working Group Inc](http://www.twg.ca)