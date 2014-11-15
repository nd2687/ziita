30.times do |i|
  article = Article.new(
    account_id: 1,
    title: "Ruby 〜〜について その ( #{i+1} )",
    body: 'あああ' * 200
  )
  article.save
end
