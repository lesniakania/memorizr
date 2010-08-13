module ApplicationHelper
  def error_on(object, attribute)
    error = object.errors.respond_to?(:"[]") ? object.errors[attribute].try(:first) : object.errors.on(attribute).try(:first)
    error = error.first if error.is_a?(Array)
    e = error ? %(<span class="error">#{error}</span>) : ""
    e.html_safe
  end
end
