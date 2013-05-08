module Blog::ApplicationHelper
  
  def comfy_blog_form_for(record_or_name_or_array, *args, &proc)
    options = args.extract_options!
    form_for(
      record_or_name_or_array,
      *(args << options.merge(:builder => ComfyBlog::FormBuilder)), # .config.form_builder.to_s.constantize)),
      &proc
    )
  end
  
  # URL helpers for blog_post_(path/url)
  %w(path url).each do |type|
    define_method "blog_post_#{type}" do |post|
      send("dated_blog_post_#{type}", post.year, ("%02d" % post.month), post.slug)
    end
  end
  
  def blah
    'blah'
  end
  
end
