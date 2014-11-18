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

  validates :title, presence: true
  validates :body, presence: true
end
