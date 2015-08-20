module ApplicationHelper
  def activek_button_class(path)
    "btn-primary" if current_page?(path)
  end
end
