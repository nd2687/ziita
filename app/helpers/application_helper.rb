module ApplicationHelper
  include HtmlBuilder

  def flash_messages
    markup do |m|
      m.div(flash[:alert], class: 'alert alert-danger', role: 'alert') if flash[:alert].present?
      m.div(flash[:notice], class: 'alert alert-info', role: 'alert') if flash[:notice].present?
    end
  end

  def error_message(model)
    text = raw('')
    model.errors.full_messages.each do |msg|
       text << content_tag(:p, msg, style: "color: red;")
    end
    text
  end
end
