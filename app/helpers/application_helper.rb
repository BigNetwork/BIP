module ApplicationHelper

  def timeago(time, options = {})
    options[:class] ||= "timeago"
    if options[:inner_html]
      inner_html = options[:inner_html]
      options[:inner_html] = nil
    else
      inner_html = time.to_s
    end
    content_tag(:abbr, inner_html, options.merge(:title => time.getutc.iso8601)) if time
  end

end
