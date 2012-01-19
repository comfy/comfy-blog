module Blog::ApplicationHelper
  
  def comfy_blog_form_for(record_or_name_or_array, *args, &proc)
    options = args.extract_options!
    form_for(
      record_or_name_or_array,
      *(args << options.merge(:builder => ComfyBlog.config.form_builder.to_s.constantize)),
      &proc
    )
  end
  
  def blog_post_path(post)
    dated_blog_post_path(post.year, post.month, post.slug)
  end
  
end
