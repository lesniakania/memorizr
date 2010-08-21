module ApplicationHelper
  def error_on(object, attributes, options={})
    error = ""
    if attributes.is_a?(Array)
      error = attributes.map { |a| object.errors[a] }.compact.flatten.first
    else
      error = object.errors.respond_to?(:"[]") ? object.errors[attributes].try(:first) : object.errors.on(attributes).try(:first)
      error = error.first if error.is_a?(Array)
    end
    e = error ? content_tag(:span, error.strip, { :class => 'error' }.merge(options)) : ""
    e.html_safe
  end
end
