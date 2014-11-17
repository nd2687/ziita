class ArticlesController < ApplicationController
  layout :resolve_layout

  def index
    @articles = Article.all
  end

  def show
    @article = Article.find(params[:id])
    @comments = @article.comments
  end

  def new
    @article = Article.new
  end

  private
  def resolve_layout
    case action_name
    when "new", "edit"
      "preview"
    else
      "user"
    end
  end
end
