class User::ArticlesController < User::Base
  def index
    @articles = actual_user.articles
  end

  def show
    @article = actual_user.articles.find(params[:id])
    @comments = @article.comments
  end
end
