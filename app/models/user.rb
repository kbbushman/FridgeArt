class User < ApplicationRecord

	has_many :children
	has_many :galleries
	has_many :photos

	has_secure_password

  validates :first_name, :last_name, :email, presence: true
  validates :email, uniqueness: true
  validates :password, presence: true, length: { minimum: 6 }, :on => :create

  def self.confirm(params)
    @user = User.find_by({email: params[:email]})
    @user ? @user.authenticate(params[:password]) : false
  end

end
