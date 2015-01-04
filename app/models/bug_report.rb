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

class BugReport < ActiveRecord::Base
  validates :title, :body, presence: true
end
