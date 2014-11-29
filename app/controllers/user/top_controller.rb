class User::TopController < User::Base
  def index
    if params[:format].in?(["jpg", "png", "gif"])
      send_image
    end

    if params[:tag]
      @articles = actual_user.articles.tagged_with(params[:tag]).order(created_at: :desc)
    else
      @articles = actual_user.articles.order(created_at: :desc)
    end
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
