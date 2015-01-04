# == Schema Information
#
# Table name: bug_reports
#
#  id          :integer          not null, primary key
#  title       :string(255)      not null
#  body        :string(255)      not null
#  completable :boolean          default("0"), not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

require 'test_helper'

class BugReportTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
