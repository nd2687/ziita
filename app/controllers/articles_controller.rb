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

end
