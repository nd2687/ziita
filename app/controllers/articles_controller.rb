class ArticlesController < ApplicationController

  def index
    if params[:tag]
      @articles = Article.where(published: true).tagged_with(params[:tag]).order(created_at: :desc)
    else
      @articles = Article.where(published: true).order(created_at: :desc)
    end
    render "articles/index"
  end

  def show
    @article = Article.find_by_access_token(params[:access_token])
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
end
