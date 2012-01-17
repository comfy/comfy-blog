module SofaBlog::ApplicationHelper
  
  def sofa_blog_form_for(record_or_name_or_array, *args, &proc)
    options = args.extract_options!
    form_for(
      record_or_name_or_array,
      *(args << options.merge(:builder => SofaBlog.config.form_builder.to_s.constantize)),
      &proc
    )
  end
  
  def blog_post_path(post)
    
  end
  
end
