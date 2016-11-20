class Child < ApplicationRecord
  belongs_to :user
  has_many :galleries
end
