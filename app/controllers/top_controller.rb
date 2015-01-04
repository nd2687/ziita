class TopController < ApplicationController
  layout :resolve_layout

  def index
    @tags = Article.tag_counts.map{|t|t.name}.sort
    if params[:tag]
      @articles = Article.articles_list.tagged_with(params[:tag])
    else
      @articles = Article.articles_list
    end
  end

  def ziita
  end

  private
  def resolve_layout
    case action_name
    when "ziita"
      "html_page"
    else
      "user"
    end
  end
end
