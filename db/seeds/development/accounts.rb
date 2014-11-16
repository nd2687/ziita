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
end
