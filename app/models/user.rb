class User < ApplicationRecord
	has_many :children
	has_many :galleries
	has_many :photos
end
