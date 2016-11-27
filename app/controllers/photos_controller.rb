class PhotosController < ApplicationController

	before_action :get_user
	before_action :get_child
	before_action :get_gallery
	before_action :get_photo, only: [:show, :edit, :update, :destroy]
	before_action :logged_in?, except: [:show]
	before_action :account_owner?, except: [:show]

	def index
		@photos = @gallery.photos
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
		  redirect_to user_child_gallery_path(@user, @child, @gallery)
		else
		  flash[:error] = @photo.errors.full_messages.join('. ')
		  render :new
		end
	end

	def show
	end

	def edit
	end

	def update
			if @photo.update(update_photo_params)
		  flash[:success] = 'Photo Updated Successfully.'
		  redirect_to user_child_gallery_path(@user, @child.id, @gallery.id)
		else
		  flash[:error] = @gallery.errors.full_messages.join('. ')
		  render :back
		end
	end

	def destroy
		@photo.destroy
		if @photo.destroy
		  flash[:success] = 'Photo Deleted Successfully.'
		  redirect_to user_child_gallery_path(@user, @child, @gallery)
		else
		  flash[:error] = @photo.errors.full_messages.join('. ')
		  render :back
		end
	end


	private

	def create_photo_params
		params.require(:photo).permit(:photo_name, :photo_description, :image)
	end

	def update_photo_params
		params.require(:photo).permit(:photo_name, :photo_description)
	end

	def get_user
    @user = User.friendly.find(params[:user_id])
  end

	def get_child
		@child = Child.find(params[:child_id])
	end

	def get_gallery
		@gallery = Gallery.find(params[:gallery_id])
	end

	def get_photo
    @photo = Photo.find(params[:id])
  end

  def account_owner?
    if current_user != Child.find(params[:child_id]).user
      flash[:error] = 'You do not have permission.'
      redirect_to current_user
    end
  end

end
