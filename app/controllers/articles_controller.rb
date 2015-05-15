class ArticlesController < ApplicationController
  def index
    if params[:tag]
      @articles = Article.articles_list.tagged_with(params[:tag])
    else
      @articles = Article.articles_list
    end
    render "articles/index"
  end

  def show
    @article = Article.find_by_access_token(params[:access_token])
    @comment = @article.comments.build
    @comments = @article.comments
  end

  def like
    @article = Article.find_by_access_token(params[:access_token])
    current_user.stacked_articles << @article
    flash.notice = "stacked!"
    redirect_to @article
  end

  def unlike
    current_user.stacked_articles.delete(Article.find_by_access_token(params[:access_token]))
    redirect_to @article
  end

  def more
    @articles = Article.articles_list(older_than: params[:older_than])
    render json: { html: render_to_string("more") }
  end
end
