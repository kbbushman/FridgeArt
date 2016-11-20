class Child < ApplicationRecord

  belongs_to :user
  has_many :galleries

  validates :child_name, presence: true

end
