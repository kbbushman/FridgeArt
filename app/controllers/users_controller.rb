class UsersController < ApplicationController

	before_action :get_user, only: [:show]

	def index
		@users = User.all
	end

	def show

	end

	def new
		@user = User.new
	end

	def create
		@user = User.create(create_user_params)
		if @user.save
			redirect_to @user
		else
			flash[:error] = @user.errors.full_messages.join('. ')
      render :new
		end
	end


	def get_user
    @user = User.find(params[:id])
  end

  def create_user_params
    params.require(:user).permit(:first_name, :last_name, :email, :password)
  end

end
