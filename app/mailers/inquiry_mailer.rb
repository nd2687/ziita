class InquiryMailer < ActionMailer::Base
  default from: 'ziita@ziita.jp' # サーバーのアドレス
  default to: 'tkwn1washere@gmail.com'

  def received_email(inquiry)
    @inquiry = inquiry
    mail(subject: "お問い合わせを承りました。")
  end
end
