module ApplicationHelper
  include HtmlBuilder

  def flash_messages
    markup do |m|
      m.div(flash[:alert]) if flash[:alert].present?
      m.div(flash[:notice]) if flash[:notice].present?
    end
  end
end
