module ApplicationHelper
  def active_class(path)
    "is-active" if current_page?(path)
  end
end
