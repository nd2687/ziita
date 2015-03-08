class CommentsController < ApplicationController
  before_action :prepare_article

  def new
    @comment = Comment.new
  end

  def create
    @comment = Comment.new(name: params[:name], body: params[:body])
    @comment.article = @article
    if @comment.save!
      render json: [@comment.name, @comment.body, @comment.created_at.strftime("%Y/%m/%d %H:%M")]
    end
  end

  private
  def prepare_article
    @article = Article.find_by_access_token(params[:article_access_token])
  end
end
