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

  def create
    @article = Article.new(article_params)
    @article.account = current_user
    if @article.save
      flash.notice = "新規記事を投稿しました。"
      redirect_to user_articles_path(identify_name: current_user.identify_name)
    else
      flash.now[:alert] = "新規記事の投稿に失敗しました。"
      render action: 'new', layout: 'preview'
    end
  end

  def edit
    @article = Article.find(params[:id])
  end

  def update
    @article = Article.find(params[:id])
    @article.assign_attributes(article_params())
    @article.account = current_user
    if @article.save
      flash.notice = "記事を更新しました。"
      redirect_to user_article_path(identify_name: current_user.identify_name, id: @article)
    else
      flash.now[:alert] = "記事の更新に失敗しました。"
      render action: "edit", layout: 'preview'
    end
  end

  def destroy
  end

  private
  def article_params
    params.require(:article).permit(
      :title, :body
    )
  end

  def resolve_layout
    case action_name
    when "new", "edit"
      "preview"
    else
      "user"
    end
  end
end
