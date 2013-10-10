module Blog::ApplicationHelper
  
  # URL helpers for blog_post_(path/url)
  %w(path url).each do |type|
    define_method "blog_post_#{type}" do |post|
      send("blog_posts_dated_#{type}", post.year, ("%02d" % post.month), post.slug)
    end
  end
  
end
