class ArticlesController < ApplicationController

  def index
    if params[:tag]
      @articles = Article.tagged_with(params[:tag]).order(created_at: :desc)
    else
      @articles = Article.all.order(created_at: :desc)
    end
    render "articles/index"
  end

  def show
    @article = Article.find(params[:id])
    @comments = @article.comments
  end

  def like
    @article = Article.find(params[:id])
    current_user.stacked_articles << @article
    flash.notice = "stacked!"
    redirect_to @article
  end

  def unlike
    current_user.stacked_articles.delete(Article.find(params[:id]))
    redirect_to @article
  end
end
