30.times do |i|
  article = Article.new(
    title: "Ruby 〜〜について その ( #{i+1} )",
    body: 'あああ' * 200
  )
  article.save
end
