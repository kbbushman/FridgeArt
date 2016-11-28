class UserPhotosController < ApplicationController

	before_action :get_user
	before_action :get_gallery, only: [:new, :create]
	before_action :get_photo, only: [:show, :edit, :update, :destroy]
	before_action :logged_in?, except: [:index, :show]
	before_action :account_owner?, except: [:index, :show]

	def index
		@photos = @user.photos
	end

	def show
	end

	def new
		@photo = Photo.new
	end

	def create
		@photo = @user
						 .photos
						 .new(create_photo_params)
		@photo.gallery_id = @gallery.id
		@photo.save

		if @photo.save
		  flash[:success] = 'Photo Added Successfully.'
		  redirect_to user_gallery_path(@user, @gallery)
		else
		  flash[:error] = @photo.errors.full_messages.join('. ')
		  render :new
		end
	end

	def edit
	end

	def update
			if @photo.update(update_photo_params)
		  flash[:success] = 'Photo Updated Successfully.'
		  redirect_to user_gallery_path(@user, @photo.gallery)
		else
		  flash[:error] = @gallery.errors.full_messages.join('. ')
		  render :back
		end
	end

	def destroy
		@photo.destroy
		if @photo.destroy
		  flash[:success] = 'Photo Deleted Successfully.'
		  redirect_to :back
		else
		  flash[:error] = @photo.errors.full_messages.join('. ')
		  render :back
		end
	end


	private

	def get_user
    @user = User.friendly.find(params[:user_id])
  end

	def get_photo
    @photo = Photo.find(params[:id])
  end

	def get_gallery
    @gallery = Gallery.find(params[:id])
  end

  def create_photo_params
  	params.require(:photo).permit(:photo_name, :photo_description, :image)
  end

  def update_photo_params
  	params.require(:photo).permit(:photo_name, :photo_description)
  end

  def photo_params
  	params.require(:child).permit(:child_name)
  end

  def account_owner?
    if current_user != @user
      flash[:error] = 'You do not have permission.'
      redirect_to current_user
    end
  end

end
