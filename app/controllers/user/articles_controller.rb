class User::ArticlesController < User::Base
  def index
    @articles = actual_user.articles
  end

  def show
    @article = actual_user.articles.find_by(id: params[:id])
    if @article
      @comments = @article.comments
    else
      raise ActionController::RoutingError,
        "No routes matches #{request.path.inspect}"
    end
  end
end
