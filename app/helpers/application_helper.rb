module ApplicationHelper
  def active_class(path)
    "is-active" if current_page?(path)
  end

  def body_class
    controller.controller_name
  end

  def compliments?
    controller.controller_name == 'compliments'
  end
end
