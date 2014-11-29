# == Schema Information
#
# Table name: articles
#
#  id         :integer          not null, primary key
#  account_id :integer          not null
#  title      :string(255)      not null
#  body       :text             not null
#  created_at :datetime
#  updated_at :datetime
#
# Indexes
#
#  index_articles_on_account_id  (account_id)
#

class Article < ActiveRecord::Base
  belongs_to :account
  has_many :comments
  has_many :stacks, dependent: :destroy
  has_many :stackers, through: :stacks, source: :account

  validates :title, presence: true,
                    length: { maximum: 64 }
  validates :body, presence: true
  validate :validate_tag

  acts_as_taggable

  def validate_tag
    tag_list.each do |tag|
      errors.add(:tag_list, :too_long) unless tag.length < 32
      errors.add(:tag_list, :format) unless tag =~ /\A[-a-zA-Z\W_ ]+\z/
    end
  end
end
