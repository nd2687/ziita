# == Schema Information
#
# Table name: account_images
#
#  id           :integer          not null, primary key
#  account_id   :integer          not null
#  data         :binary(65535)
#  content_type :string(255)
#  created_at   :datetime
#  updated_at   :datetime
#
# Indexes
#
#  index_account_images_on_account_id  (account_id)
#

class AccountImage < ActiveRecord::Base
  belongs_to :account

  validate :check_image

  attr_reader :uploaded_image

  IMAGE_TYPES = { "image/jpeg" => "jpg", "image/gif" => "gif",
                  "image/png" => "png" }

  def extension
    IMAGE_TYPES[content_type]
  end

  def check_image
    if data
      if data.size > 64.kilobytes
        errors.add(:uploaded_image, :too_big_image)
      end
      unless IMAGE_TYPES.has_key?(content_type)
        errors.add(:uploaded_image, :invalid_image)
      end
    end
  end
end
