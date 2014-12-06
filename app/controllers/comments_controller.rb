class CommentsController < ApplicationController
  before_action :prepare_article

  def new
    @comment = Comment.new
  end

  def create
    @comment = Comment.new(comment_params)
    @comment.article = @article
    @comment.name = "名無し" if @comment.name.empty?
    if @comment.save
      flash.notice = "コメントを追加しました！"
      redirect_to [ @article ]
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
    @article = Article.find_by_access_token(params[:article_access_token])
  end
end
