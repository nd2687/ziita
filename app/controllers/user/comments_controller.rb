class User::CommentsController < User::Base
  def index
    @article = Article.find(params[:article_id])
    @comments = @article.comments
  end

  def new
    @article = Article.find(params[:article_id])
    @comment = Comment.new
  end

  def create
    @article = Article.find(params[:article_id])
    @comment = Comment.new(comment_params)
    @comment.article = @article
    @comment.name = "名無し" if @comment.name.empty?
    if @comment.save
      flash.notice = "コメントを追加しました！"
      redirect_to [ :user, @article ]
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
end
