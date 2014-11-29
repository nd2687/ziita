class User::CommentsController < User::Base
  before_action :prepare_article

  def new
    @comment = Comment.new
  end

  def create
    @comment = Comment.new(comment_params)
    @comment.article = @article
    @comment.name = current_user.identify_name if @article.account == current_user
    @comment.name = "名無し" if @comment.name.empty?
    if @comment.save
      flash.notice = "コメントを追加しました！"
      redirect_to user_article_path(identify_name: actual_user.identify_name, id: @article.id)
    else
      flash.now[:alert] = "コメントの追加に失敗しました。"
      render action: 'new'
    end
  end

  private
  def comment_params
    params.require(:comment).permit(
      :name, :body
    )
  end

  def prepare_article
    @article = actual_user.articles.find(params[:article_id])
  end
end
