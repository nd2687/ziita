# == Schema Information
#
# Table name: comments
#
#  id         :integer          not null, primary key
#  article_id :integer          not null
#  name       :string(255)
#  body       :text             not null
#  created_at :datetime
#  updated_at :datetime
#
# Indexes
#
#  index_comments_on_article_id  (article_id)
#

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :comment do
  end
end
