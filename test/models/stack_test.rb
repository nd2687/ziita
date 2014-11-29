# == Schema Information
#
# Table name: stacks
#
#  id         :integer          not null, primary key
#  account_id :integer          not null
#  article_id :integer          not null
#  created_at :datetime
#  updated_at :datetime
#
# Indexes
#
#  index_stacks_on_account_id_and_article_id  (account_id,article_id) UNIQUE
#  stacks_article_id_fk                       (article_id)
#

require 'test_helper'

class StackTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
