class CommentsController < ApplicationController
  before_action :prepare_article

  def new
    @comment = Comment.new
  end

  def create
    @comment = @article.comments.build(comment_params)
    if @comment.name.blank?
      @comment.name = current_user ? current_user.identify_name : "名無し"
    end
    if @comment.save
      render json: [ @comment.to_json, @comment.created_at.strftime("%Y/%m/%d %H:%M") ]
    else
      render json: { success: false }
    end
  end

  private
  def prepare_article
    @article = Article.find_by_access_token(params[:article_access_token])
  end

  def comment_params
    params.require(:comment).permit(
      :name, :body
    )
  end
end
