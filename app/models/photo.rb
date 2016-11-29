class Photo < ApplicationRecord
  belongs_to :gallery
  belongs_to :user

  validates :image_file_name, presence: true

  has_attached_file :image, :styles => { large: "1000>", medium: "300x300#", thumb: "180x180#" }, :default_url => ":style/default.png"
  # Validate content type
  validates_attachment_content_type :image, content_type: /\Aimage/
  # Validate filename
  validates_attachment_file_name :image, matches: [/png\z/, /jpe?g\z/]
  # Validate attachment size
  validates_with AttachmentSizeValidator, attributes: :image, less_than: 2.megabytes

end
