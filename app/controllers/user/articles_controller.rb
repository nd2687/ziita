class User::ArticlesController < User::Base
  def index
    @articles = current_user.articles
  end

  def show
    @article = current_user.articles.find(params[:id])
    @comments = @article.comments
  end
end
