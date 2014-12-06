class User::ArticlesController < User::Base
  before_action :only_current_user, except: [ :index, :show, :like ]

  layout :resolve_layout

  def index
    if params[:tag]
      @articles = actual_user.articles.tagged_with(params[:tag]).order(created_at: :desc)
    else
      @articles = actual_user.articles.order(created_at: :desc)
    end
  end

  def show
    @article = actual_user.articles.find_by_access_token(params[:access_token])
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
    @article = Article.find_by_access_token(params[:access_token])
  end

  def update
    @article = Article.find_by_access_token(params[:access_token])
    @article.assign_attributes(article_params)
    @article.account = current_user
    if @article.save
      flash.notice = "記事を更新しました。"
      redirect_to user_article_path(identify_name: current_user.identify_name, access_token: @article.access_token)
    else
      flash.now[:alert] = "記事の更新に失敗しました。"
      render action: "edit", layout: 'preview'
    end
  end

  def destroy
    @article = Article.find_by_access_token(params[:access_token])
    if @article.destroy
      flash.notice = "記事を削除しました。"
      redirect_to user_articles_path(identify_name: current_user.identify_name)
    else
      flash.now[:alert] = "記事の削除に失敗しました。"
      redirect_to :back
    end
  end

  def like
    @article = Article.find_by_access_token(params[:access_token])
    current_user.stacked_articles << @article
    flash.notice = "stacked!"
    redirect_to user_article_path(identify_name: actual_user.identify_name, access_token: @article.access_token)
  end

  def unlike
    current_user.stacked_articles.delete(Article.find_by_access_token(params[:access_token]))
    flash.notice = "unstack"
    redirect_to stacked_user_articles_path(identify_name: actual_user.identify_name)
  end

  def stacked
    @articles = current_user.stacked_articles.order("stacks.created_at DESC").includes(:account)
  end

  private
  def article_params
    params.require(:article).permit(
      :title, :body, :tag_list
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

  def only_current_user
    if current_user != actual_user
      flash.alert = "他ユーザーの記事編集はできません。"
      redirect_to :root
    end
  end
end
