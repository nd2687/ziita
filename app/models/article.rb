# == Schema Information
#
# Table name: articles
#
#  id           :integer          not null, primary key
#  account_id   :integer          not null
#  title        :string(255)      not null
#  body         :text             not null
#  created_at   :datetime
#  updated_at   :datetime
#  access_token :string(8)        not null
#
# Indexes
#
#  index_articles_on_access_token  (access_token) UNIQUE
#  index_articles_on_account_id    (account_id)
#

class Article < ActiveRecord::Base
  belongs_to :account
  has_many :comments, dependent: :destroy
  has_many :stacks, dependent: :destroy
  has_many :stackers, through: :stacks, source: :account

  validates :title, presence: true, length: { maximum: 64 }
  validates :body, presence: true
  validate :validate_tag
  validates_uniqueness_of :access_token
  validates_presence_of :access_token
  after_initialize :set_access_token

  acts_as_taggable

  def validate_tag
    tag_list.each do |tag|
      errors.add(:tag_list, :too_long) unless tag.length < 32
      errors.add(:tag_list, :format) unless tag =~ /\A[-a-zA-Z\W_ ]+\z/
    end
  end

  def to_param
    return access_token
  end

  private
  def set_access_token
    self.access_token = self.access_token.blank? ? generate_access_token : self.access_token
  end

  def generate_access_token
    tmp_token = SecureRandom.urlsafe_base64(6)
    self.class.where(access_token: tmp_token).blank? ? tmp_token : generate_access_token
  end
end
