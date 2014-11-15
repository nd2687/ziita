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

require 'test_helper'

class ArticleTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
