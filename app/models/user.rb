class User < ApplicationRecord
	has_many :children
	has_many :photos
end
