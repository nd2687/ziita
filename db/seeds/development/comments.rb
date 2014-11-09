articles = Article.all

articles.each do |article|
  rand = [*1..10].sample
  rand.times do |i|
    comment = Comment.new(
      name: "ほげ太郎#{i}",
      body: "コメント" * 20
    )
    comment.article = article
    comment.save
  end
end
