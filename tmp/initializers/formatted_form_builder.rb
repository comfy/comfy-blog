class FormattedFormBuilder < ActionView::Helpers::FormBuilder
  
  %w[ date_select text_field password_field text_area file_field datetime_select ].each do |selector|
    src = <<-end_src
      def #{selector}(method, options = {})
        if (options[:simple] == true)
          super(method, options)
        else
          options.merge!(:size=> '') if #{%w{text_field password_field}.include?(selector)}
          standard_field('#{selector}', method, options) { super(method, options) } 
        end
      end
    end_src
    class_eval src, __FILE__, __LINE__
  end
  
  def standard_field(type, method, options={}, &block)
    description = options.delete(:desc)
    content = options.delete(:content)
    prev_content = options.delete(:prev_content)
    label = label_for(method, options)
    required = options.delete(:required)
    check_box_details = options.delete(:check_box_details)
    text_snippet = options.delete(:text_snippet)
    %{
      <div class='form_element #{type}_element'>
        #{"<div class='text_snippet'>"+text_snippet+"</div>" if text_snippet}
        <div class='label'>
          #{description(description) || '&nbsp;' if type == 'check_box' }
          #{label if type != 'check_box' }
          #{@template.content_tag(:span, '*', :class => 'required_ind') if required }
        </div>
        <div class='value'>
          #{prev_content}#{yield}#{content}
          #{error_messages_for(method)}
          #{description(description) if type != 'check_box'}
          #{description(check_box_details) if type == 'check_box'}
        </div>
      </div>
    }.html_safe
  end

  # generic container for all things form
  def element(label = '&nbsp;', value = '', type = 'text_field', &block)
    value += @template.capture(&block) if block_given?
    %{
      <div class='form_element #{type}_element'>
        <div class='label'>
          #{label}
        </div>
        <div class='value'>
          #{value}
        </div>
      </div>
    }.html_safe
  end
  
  def check_box(method, options = {}, checked_value = "1", unchecked_value = "0")
    options[:content] = label_for(method, options)
    options[:label] = ''
    standard_field('check_box', method, options) { super(method, options, checked_value, unchecked_value) }     
  end
  
  def radio_button(method, tag_value, options = {})
    if options && options[:choices]
      radios = options.delete(:choices).collect{|choice| %{<div class="radio_button">}+super(method, choice[0], options) + %{<label for="#{object_name.to_s.gsub(']', '').gsub('[', '_')}_#{method}_#{choice[0]}">#{choice[1]}</label></div>}}.join.html_safe
      standard_field('radio_button', method, options) { radios }
    elsif options && options[:value_name]
        standard_field('radio_button', method, options) { super(method, tag_value) + %{<label for="#{object_name}_#{method}_#{tag_value}">#{options[:value_name]}</label><div class="clearfloat"></div>}.html_safe}
    else
      standard_field('radio_button', method, options) { super(method, tag_value, options = {}) }
    end
  end
  
  def select(method, choices, options = {}, html_options = {})
    standard_field('select', method, options) { super(method, choices, options, html_options) } 
  end
    
  def hidden_field(method, options = {}, html_options = {})
    super(method, options)
  end
  
  def submit(value, options={}, &block)
    cancel_link = @template.capture(&block) if block_given?
    cancel_link ||= options[:cancel_url] ? ' or ' + options.delete(:cancel_url) : ''
    if options[:show_ajax_loader]
      options[:onclick] = "$(this).parent().next().css('display', 'block');$(this).parent().hide();"
    end
    if options[:image_button] == true
      submit_id = Time.now.usec
      out = @template.content_tag(:div,
        %{
          #{super(value, options.merge(:style=>'visibility:hidden;position: absolute', :id => submit_id)).html_safe}
          <a class="red_button" href="" onclick="$('##{submit_id}').closest('form').submit();return false"><span>#{value}</span></a>
          #{cancel_link.html_safe}
        }.html_safe, :class => 'form_element submit_element').html_safe
      
    else
      out = @template.content_tag(:div, super(value, options) + cancel_link.html_safe, :class => 'form_element submit_element').html_safe
    end
    
    if options[:show_ajax_loader]
      out << %{
        <div class="form_element submit_element" style="display:none">
          <div class="submit_ajax_loader">#{options[:show_ajax_loader]}</div>
        </div>
      }.html_safe
    end
    out.html_safe
  end
  
  def label_for(method, options)
    label = options.delete(:label) || method.to_s.titleize.capitalize
    "<label for=\"#{object_name}_#{method}\">#{label}</label>"
  end  
  
  def description(description)
    "<div class='description'>#{description}</div>" unless description.nil?
  end
  
  def error_messages
    if object && !object.errors.empty?
      message = object.errors[:base].present? ? object.errors[:base]: 'There were some problems submitting this form. Please correct all the highlighted fields and try again'
      @template.content_tag(:div, message, :class => 'form_error')
    end
  end
  
  def error_messages_for(method)
    if (object and object.respond_to?(:errors) and errors = object.errors[method])
      "<div class='errors'>#{errors.is_a?(Array) ? errors.first : errors}</div>"
    else
      ''
    end
  end
  
  def formatted_fields_for(record_or_name_or_array, *args, &block)
    options = args.extract_options!
    options.merge!(:builder => FormattedFormBuilder)
    fields_for(record_or_name_or_array, *(args << options), &block)
  end
end
