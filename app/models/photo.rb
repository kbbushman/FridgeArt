class Photo < ApplicationRecord
  belongs_to :gallery
  belongs_to :user

  validates :image, attachment_presence: true
  validates_with AttachmentPresenceValidator, attributes: :image
  validates_with AttachmentSizeValidator, attributes: :avatar, less_than: 2.megabytes

end
