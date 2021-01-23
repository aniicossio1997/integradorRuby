module ApplicationHelper
  def get_flash_class(key)
    case key.to_sym
    when :notice
      'success'
    when :alert
      'danger'
    end
  end

  def print_badge(value)
    "<span class='badge badge-secondary mr-1'>#{value}</span>"
  end

  def icon(icon, options = {})
    file = File.read("node_modules/bootstrap-icons/icons/#{icon}.svg")
    doc = Nokogiri::HTML::DocumentFragment.parse file
    svg = doc.at_css 'svg'
    if options[:class].present?
      svg['class'] += " " + options[:class]
    end
      doc.to_html.html_safe
  end
end
