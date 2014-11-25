class TopController < ApplicationController
  def index
    @tags = Article.tag_counts.map{|t|t.name}
  end
end
