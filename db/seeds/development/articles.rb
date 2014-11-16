50.times do |i|
  account_id = Random.rand(1 .. 7)
  article = Article.new(
    account_id: account_id,
    title: "Ruby 〜〜について その ( #{i+1} )",
    body: 'あああ' * 200
  )
  article.save!
end
