class TopController < ApplicationController
  def index
    @tags = Article.tag_counts.map{|t|t.name}.sort
    if params[:tag]
      @articles = Article.where(published: true).tagged_with(params[:tag]).order(created_at: :desc)
    else
      @articles = Article.where(published: true).order(created_at: :desc)
    end
  end
end
