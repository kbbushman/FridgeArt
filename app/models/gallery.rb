class Gallery < ApplicationRecord

  belongs_to :child
  belongs_to :user
  has_many :photos, dependent: :destroy

  validates :gallery_name, presence: true

end
