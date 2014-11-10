account = Account.new(
  identify_name: 'totoman',
  email: 'totoman@example.com',
  email_for_index: 'totoman@example.com',
  password: 'password',
  self_introduction: 'RailsとRubyの勉強を頑張っています。よろしくです!',
  sites: 'http://nicovideo.jp',
  company: 'rubyquitous.Inc',
  residence: 'Yokohama',
)
account.setting_password = true
account.save!
