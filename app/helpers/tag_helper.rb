module TagHelper
  def tag_link(tags)
    raw tags.map{ |t| link_to t, tag_articles_path(t) }.join(' / ')
  end

  def user_tag_link(tags)
    raw tags.map{ |t| link_to t, tag_user_articles_path(
      identify_name: actual_user.identify_name, tag: t) }.join(' / ')
  end
end
