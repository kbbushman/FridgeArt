class PhotosController < ApplicationController

	before_action :get_child, except: [:create]
	before_action :get_gallery, except: [:create]
	before_action :get_photo, only: [:show, :edit, :update, :destroy]
	before_action :logged_in?
	before_action :account_owner?

	def index
		@photos = @gallery.photos
	end

	def new
		@photo = Photo.new
	end

	def create
		@photo = current_user
						.photos
						.new(create_photo_params)
		@photo.gallery_id = params[:gallery_id]
		@photo.save

		if @photo.save
		  flash[:success] = 'Your Photo Has Been Added.'
		  redirect_to child_gallery_path(params[:child_id], @photo.gallery_id)
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
		  flash[:success] = 'Photo Updated!'
		  redirect_to child_gallery_path(@child.id, @gallery.id)
		else
		  flash[:error] = @gallery.errors.full_messages.join('. ')
		  render :back
		end
	end

	def destroy
		@photo.destroy
		if @photo.destroy
		  flash[:success] = 'Photo Has Been Deleted Successfully.'
		  redirect_to child_gallery_path(@child.id, @gallery.id)
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
      flash[:error] = 'You do not have permission to view this account'
      redirect_to current_user
    end
  end

end
