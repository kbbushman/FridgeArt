class UsersController < ApplicationController

	before_action :get_user, only: [:show, :edit, :update, :destroy]

	def index
		@users = User.all
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

	def show
	end

	def edit
	end

	def update
	  if @user.update(update_user_params)
	    flash[:success] = 'Profile Updated!'
	    redirect_to @user
	  else
	    flash[:error] = @user.errors.full_messages.join('. ')
	    render :edit
	  end
	end

	def destroy
		@user.destroy
		redirect_to root_path
	end


	private

	def get_user
    @user = User.friendly.find(params[:id])
  end

  def create_user_params
    params.require(:user).permit(:first_name, :last_name, :email, :password)
  end

  def update_user_params
    params.require(:user).permit(:first_name, :last_name, :email)
  end

end
