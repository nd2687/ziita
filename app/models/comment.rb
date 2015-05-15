# == Schema Information
#
# Table name: comments
#
#  id         :integer          not null, primary key
#  article_id :integer          not null
#  name       :string(255)
#  body       :text(65535)      not null
#  created_at :datetime
#  updated_at :datetime
#
# Indexes
#
#  index_comments_on_article_id  (article_id)
#

class Comment < ActiveRecord::Base
  belongs_to :article

  validates :name, length: { maximum: 30 }
  validates :body, presence: true
end
