class Child < ApplicationRecord

  belongs_to :user
  has_many :galleries, dependent: :destroy

  validates :child_name, presence: true

end
