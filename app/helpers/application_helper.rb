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
end
