module ApplicationHelper
  include HtmlBuilder

  def flash_messages
    markup do |m|
      m.div(flash[:alert], class: 'alert alert-danger', role: 'alert') if flash[:alert].present?
      m.div(flash[:notice], class: 'alert alert-info', role: 'alert') if flash[:notice].present?
    end
  end

  def error_message(model, attribute = nil)
    text = raw('')
    return '' if model.errors.empty?

    if attribute.present?
      model.errors.full_messages_for(attribute).each do |msg|
       text << content_tag(:p, msg, style: "color: red;")
      end
    else
      model.errors.full_messages.each do |msg|
        text << content_tag(:p, msg, style: "color: red;")
      end
    end
    text
  end

  def account_image_tag(account, options = {})
    if account.image.present?
      path =
        user_root_path(identify_name: account.identify_name, format: account.image.extension)
      link_to(image_tag(path, { alt: account.identify_name }.merge(options)), path)
    else
      ""
    end
  end

  def hbr(text)
    text = html_escape(text)
    text.gsub(/\r\n|\r|\n/, "<br />").html_safe
  end

  def page_title
    title = "Ziita"
    title = @page_title + " - " + title if @page_title
    title
  end
end
