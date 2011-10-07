class SofaBlog::FormBuilder < ActionView::Helpers::FormBuilder
  
  helpers = field_helpers -
    %w(hidden_field fields_for) +
    %w(select)
    
  helpers.each do |name|
    class_eval %Q^
      def #{name}(field, *args)
        options = args.extract_options!
        args << options
        return super if options.delete(:disable_builder)
        default_field('#{name}', field, options){ super }
      end
    ^
  end
  
  def default_field(type, field, options = {}, &block)
    errors = if object.respond_to?(:errors) && object.errors[field].present?
      "<div class='errors'>#{[object.errors[field]].flatten.first}</div>"
    end
    if desc = options.delete(:desc)
      desc = "<div class='desc'>#{desc}</div>"
    end
    %(
      <div class='form_element #{type}_element #{'errors' if errors}'>
        <div class='label'>#{label_for(field, options)}</div>
        <div class='value'>#{yield}</div>
        #{desc}
        #{errors}
      </div>
    ).html_safe
  end
  
  def label_for(field, options)
    label = options.delete(:label) || field.to_s.titleize.capitalize
    "<label for=\"#{object_name}_#{field}\">#{label}</label>".html_safe
  end
  
  def simple_field(label = nil, content = nil, options = {}, &block)
    content ||= @template.capture(&block) if block_given?
    %(
      <div class='form_element #{options.delete(:class)}'>
        <div class='label'>#{label}</div>
        <div class='value'>#{content}</div>
      </div>
    ).html_safe
  end
  
end