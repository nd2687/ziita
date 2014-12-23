100.downto(1) do |i|
  account_id = Random.rand(1 .. 7)
  tag_list = %w(ruby, php, rails, mac, ios, iphone, jquery, javascript, java, linux).sample(3)
  article = Article.new(
    account_id: account_id,
    title: "Ruby 〜〜について その ( #{i+1} )",
    body: 'あああ' * 200,
    tag_list: tag_list.join(','),
    created_at: i.days.ago
  )
  article.save!

  if i.odd?
    %w(hiroyuki takeshi nobuo takahumi kazuma).each do |name|
      stacker = Account.find_by(identify_name: name)
      if stacker.stackable_for?(article)
        stacker.stacked_articles << article
      end
    end
  end
end
