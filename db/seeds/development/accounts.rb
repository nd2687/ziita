name = %w(taro hanako hiroyuki takeshi nobuo takahumi kazuma)

name.each do |name|
  account = Account.new(
    identify_name: name,
    email: "#{name}@example.com",
    password: 'password',
    self_introduction: "RailsとRubyの勉強を頑張っています。#{name}と言います。よろしくです!",
    sites: 'http://hogehoge.jp',
    company: 'Hoge.Inc',
    residence: 'Yokohama',
  )
  account.setting_password = true
  account.save!

  fname = Rails.root.join("db/seeds/development", "account_image.jpg")
  AccountImage.create(
     account: account,
     data: File.open(fname, "rb").read,
     content_type: "image/jpeg"
    )
end
