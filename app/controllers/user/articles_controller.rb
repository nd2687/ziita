class User::ArticlesController < User::Base
  before_action :only_current_user, except: [ :index, :show, :like ]

  layout :resolve_layout

  def index
    if params[:tag]
      @articles = actual_user.articles.where(published: true).tagged_with(params[:tag]).order(created_at: :desc)
    else
      @articles = actual_user.articles.where(published: true).order(created_at: :desc)
    end
  end

  def show
    @article = actual_user.articles.find_by_access_token(params[:access_token])
    unless @article
      redirect_to user_articles_path(identify_name: actual_user.identify_name)
    end
    @comments = @article.comments
  end

  def new
    @article = current_user.articles.new
  end

  def create
    if @article = current_user.articles.last
      @article.update_attribute(:published, true)
      if @article.save
        flash.notice = "新規記事を投稿しました。"
        redirect_to user_articles_path(identify_name: current_user.identify_name)
      else
        flash.now[:alert] = "新規記事の投稿に失敗しました。"
        render action: 'new', layout: 'preview'
      end
    else
      flash.alert = "新規記事の投稿に失敗しました。"
      redirect_to :back
    end
  end

  def edit
    @article = current_user.articles.find_by_access_token(params[:access_token])
    unless @article
      redirect_to user_articles_path(identify_name: actual_user.identify_name)
    end
  end

  def update
    @article = current_user.articles.find_by_access_token(params[:access_token])
    unless @article
      redirect_to user_articles_path(identify_name: actual_user.identify_name)
    end
    @article.assign_attributes(article_params)
    if @article.save
      flash.notice = "記事を更新しました。"
      redirect_to user_article_path(identify_name: current_user.identify_name, access_token: @article.access_token)
    else
      flash.now[:alert] = "記事の更新に失敗しました。"
      render action: "edit", layout: 'preview'
    end
  end

  def destroy
    @article = current_user.articles.find_by_access_token(params[:access_token])
    unless @article
      redirect_to user_articles_path(identify_name: actual_user.identify_name)
    end
    if @article.destroy
      flash.notice = "記事を削除しました。"
      redirect_to user_articles_path(identify_name: current_user.identify_name)
    else
      flash.now[:alert] = "記事の削除に失敗しました。"
      redirect_to :back
    end
  end

  def create_temp
    if params[:article_valid] == "true"
      @article = current_user.articles.last
      @article.assign_attributes(title: params[:title], body: params[:body], tag_list: params[:tag_list])
    else
      @article = current_user.articles.build(title: params[:title], body: params[:body], tag_list: params[:tag_list])
    end
    @article.published = false
    if @article.save
      render json: { success: true }
    else
      render json: ( @article.errors.present? ? ([false] + @article.errors.full_messages) : [] )
    end
  end

  def like
    @article = Article.find_by_access_token(params[:access_token])
    unless @article
      redirect_to user_articles_path(identify_name: actual_user.identify_name)
    end
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
