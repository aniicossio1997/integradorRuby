module ApplicationHelper
  #include Pagy::Frontend
  def markdown(text)
    RedCarpet.new(text).to_html.html_safe
  end
  def show_link(link_text, link_source, icon_text)
    link_to("#{content_tag :i, "#{icon_text}", class: 'large material-icons'}#{ link_text}".html_safe,
      link_source, class: "d-flex flex-row bd-highlight btn btn-success")
  end

  def date_create(object)
    object.created_at.strftime("%-d de %B de %Y %H:%Mhs")
  end

  def date_update(object)
    object.updated_at.strftime("%-d de %B de %Y %H:%Mhs")
  end

  def get_flash_class(key)
    case key.to_sym
    when :notice
      'success'
    when :alert
      'danger'
    end
  end

  def print_badge(value)
    "<span class='badge badge-secondary mr-1'>#{value}</span>".html_safe
  end

end
