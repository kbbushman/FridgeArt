class Gallery < ApplicationRecord
  belongs_to :child
  has_many :photos
end
