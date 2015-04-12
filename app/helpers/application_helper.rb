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
    title = "Ziita | エンジニアのための技術共有サービス"
    title = @page_title + " - " + title if @page_title
    title
  end

  # タグの初期化(更新時に使用)
  def initial_tag_list(tag_list)
    raw tag_list.map{|tag| generate_tag_list(tag)}.join
  end

  def add_tag_input
    link_to 'タグを追加', '#', class: 'btn btn-warning', type: "button",
      onclick: "add_tag_field(\"#{escape_javascript(generate_tag_list)}\"); return false;"
  end

  def generate_tag_list(tag = nil)
    content = '<li class="tag_list" style="display:inline-block;margin:5px;"><input class="tag_input form-control" type="text"'
    content += " value=\"#{tag}\"" if tag
    content += ' />'
    content += remove_tag_input
    content += '</li>'
  end

  def remove_tag_input
    link_to '削除', "#", onclick: "remove_tag_field(this); return false;"
  end
end
