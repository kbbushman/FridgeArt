class User < ApplicationRecord

	has_many :children, dependent: :destroy
	has_many :galleries, dependent: :destroy
	has_many :photos, dependent: :destroy

	has_secure_password

  validates :first_name, :last_name, :email, presence: true
  validates :email, uniqueness: true
  validates :password, presence: true, length: { minimum: 6 }, :on => :create

  extend FriendlyId
  friendly_id :generate_custom_slug, use: :slugged


  def generate_custom_slug
   "#{first_name}_#{last_name}"
  end

  def self.confirm(params)
    @user = User.find_by({email: params[:email]})
    @user ? @user.authenticate(params[:password]) : false
  end

end
