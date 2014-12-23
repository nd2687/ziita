class TopController < ApplicationController
  def index
    @tags = Article.tag_counts.map{|t|t.name}.sort
    if params[:tag]
      @articles = Article.articles_list.tagged_with(params[:tag])
    else
      @articles = Article.articles_list
    end
  end
end
