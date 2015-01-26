# == Schema Information
#
# Table name: accounts
#
#  id                :integer          not null, primary key
#  identify_name     :string(255)      not null
#  email             :string(255)      not null
#  email_for_index   :string(255)      not null
#  email_publication :boolean          default("0"), not null
#  password_digest   :string(255)      not null
#  self_introduction :text(65535)
#  sites             :string(255)
#  company           :string(255)
#  residence         :string(255)
#  created_at        :datetime
#  updated_at        :datetime
#  account_token     :string(255)      default("")
#
# Indexes
#
#  index_accounts_on_account_token                      (account_token) UNIQUE
#  index_accounts_on_identify_name_and_email_for_index  (identify_name,email_for_index) UNIQUE
#

class Account < ActiveRecord::Base
  has_many :articles, dependent: :destroy
  has_one :image, class_name: 'AccountImage', dependent: :destroy
  has_one :account_identity
  has_many :stacks, dependent: :destroy
  has_many :stacked_articles, through: :stacks, source: :article
  validates_uniqueness_of :account_token
  validates_presence_of :account_token
  after_initialize :set_account_token

  accepts_nested_attributes_for :image, allow_destroy: true

  attr_accessor :password, :password_confirmation, :setting_password
  alias_method :setting_password?, :setting_password

  validates :password, presence: true, confirmation: true, on: :create

  validates :self_introduction,length: { maximum: 1000, allow_blank: true }
  validates :sites, format: { with: /(^$)|(^(http|https):\/\/[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(([0-9]{1,5})?\/.*)?$)/ix,
                              allow_blank: true }
  validates :company, length: { maximum: 32, allow_blank: true }
  validates :residence, length: { maximum: 32, allow_blank: true }
  validates_uniqueness_of :identify_name, on: :create
  validates_uniqueness_of :email, scope: :email_for_index, on: :create
  validates_format_of :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i, on: :create

  BAN_ID = %w{
    index home top help about security contact support faq form mail
    update mobile tour plan price business company store shop term
    privacy rule inquiry legal policy image css stylesheet src js
    javascript asset account user item entry article event doc word
    product download video community blog site popular i my me topic
    news info status search explore share feature upload rss widget
    api wiki auth session register login logout signup signin signout
    root postmaster webmaster show create edit update destroy new
    dashboard recruit join offer career corp school dev test bug code
    guest web root info admin guest delete remove www null 0 default
    empty page app archive bookmark captcha comment jump maintenance
    profile premium ranking setting source tool tag api rpc id reset
    post member connect self notify read recent recently bot game
    special forum category report secure contribute howto usage feed
    contest ad service system sys official message msg project new
    old first last photo config log analysis design theme lang language
    tutorial repository purpose query start get spec call phone manual
    owner license calendar organization develop developer asct book
    friend portal share group dic dict dictionary pr press release version
    error diary state graph watch infomation navi navigation site sitemap
    cart gift alpha beta tux year wiki private analytics public static
    img style script file flash swf dist xml svg cgi atom forgot server
    cgi-bin server-status balancer-manager icon ldap-status server-info svn
    account_identity
  }

  before_validation do
    self.email_for_index = email.downcase if email

    if (BAN_ID + BAN_ID.map{|id| id.pluralize}).include?(self.identify_name)
      errors.add(:identify_name, :taken)
    end
  end


  before_save do
    if setting_password?
      self.password_digest = BCrypt::Password.create(password)
    end
  end

  def authenticate(raw_password)
    if password_digest && BCrypt::Password.new(password_digest) == raw_password
      self
    else
      false
    end
  end

  def stackable_for?(article)
    article && article.account != self && !stacks.exists?(article_id: article.id)
  end

  class << self
    def create_with_omniauth(auth)
      create! do |account|
        account.provider = auth["provider"]
        account.uid = auth["uid"]
        account.identify_name = auth["user_info"]["nickname"]
      end
    end

    def create_unique_string
      SecureRandom.uuid
    end

    def create_unique_email
      Account.create_unique_string + "@example.com"
    end
  end

  def to_param
    return account_token
  end

  def drafts
    articles.where(published: false)
  end

  private
  def set_account_token
    self.account_token = self.account_token.blank? ? generate_account_token : self.account_token
  end

  def generate_account_token
    tmp_token = SecureRandom.urlsafe_base64(15)
    self.class.where(account_token: tmp_token).blank? ? tmp_token : generate_account_token
  end
end
