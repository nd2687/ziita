class TopController < ApplicationController
  def index
    @tags = Article.tag_counts.map{|t|t.name}.sort
    if params[:tag]
      @articles = Article.tagged_with(params[:tag]).order(created_at: :desc)
    else
      @articles = Article.all.order(created_at: :desc)
    end
  end
end
