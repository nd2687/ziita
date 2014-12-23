class User::TopController < User::Base
  def index
    if params[:format].in?(["jpg", "png", "gif"])
      send_image
    end
    @articles = actual_user.articles.order(created_at: :desc).limit(20)
    @stacked_count = 0
    actual_user.articles.map{|article| @stacked_count += article.stacks.count }
    @stacked_count
  end

  private
  def send_image
    if actual_user.image.present?
      send_data actual_user.image.data,
        type: actual_user.image.content_type, disposition: "inline"
    else
      raise NotFound
    end
  end
end
