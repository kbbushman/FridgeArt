class UserGalleriesController < ApplicationController

	before_action :get_user, only: [:index, :show, :edit, :update, :destroy]
	before_action :get_gallery, only: [:show, :edit, :update, :destroy]
	before_action :logged_in?, except: [:show]
	before_action :account_owner?, except: [:show]


	def index
		@galleries = @user.galleries
	end

	def show
		@photo = @gallery.photos
	end

	def edit
	end

	def update
		if @gallery.update(gallery_params)
		  flash[:success] = 'Gallery Updated!'
		  redirect_to user_galleries_path(@user)
		else
		  flash[:error] = @gallery.errors.full_messages.join('. ')
		  render :edit
		end
	end

	def destroy
		@gallery.destroy
		if @gallery.destroy
		  flash[:success] = 'Gallery Deleted Successfully.'
		  redirect_to :back
		else
		  flash[:error] = @gallery.errors.full_messages.join('. ')
		  render :back
		end
	end

	private

	def get_user
    @user = User.friendly.find(params[:user_id])
  end

	def get_gallery
    @gallery = Gallery.find(params[:id])
  end

  def gallery_params
  	params.require(:gallery).permit(:gallery_name)
  end

  def account_owner?
    if current_user != @user
      flash[:error] = 'You do not have permission.'
      redirect_to current_user
    end
  end

end
