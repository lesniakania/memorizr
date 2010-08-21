module ApplicationHelper
  def error_on(object, attribute, options={})
    error = object.errors.respond_to?(:"[]") ? object.errors[attribute].try(:first) : object.errors.on(attribute).try(:first)
    error = error.first if error.is_a?(Array)
    e = error ? content_tag(:span, error.strip, { :class => 'error' }.merge(options)) : ""
    e.html_safe
  end
end
