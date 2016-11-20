class User < ApplicationRecord
	has_many :children
	has_many :galleries
	has_many :photos

	has_secure_password

  validates :first_name, :last_name, :email, :password, presence: true, :on => :create
  validates :email, uniqueness: true
  validates :password, length: { minimum: 6 }, :on => :create

end
