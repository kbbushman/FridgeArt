class PhotosController < ApplicationController

	before_action :get_photo, only: [:show, :edit, :update, :destroy]

	def index
		@photos = Photo.all
	end

	def new
		@photo = Photo.new
	end

	def create
		@photo = current_user
						.photos
						.new(create_photo_params)

		@photo.save

		if @photo.save
		  flash[:success] = 'Your Photo Has Been Added.'
		  redirect_to current_user
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
		  redirect_to @photo
		else
		  flash[:error] = @gallery.errors.full_messages.join('. ')
		  render :edit
		end
	end

	def destroy
		@photo.destroy
		if @photo.destroy
		  flash[:success] = 'Photo Has Been Deleted Successfully.'
		  redirect_to current_user
		else
		  flash[:error] = @photo.errors.full_messages.join('. ')
		  render :back
		end
	end


	private

	def create_photo_params
		params.require(:photo).permit(:photo_name, :photo_description, :image, :gallery_id)
	end

	def update_photo_params
		params.require(:photo).permit(:photo_name, :photo_description)
	end

	def get_photo
    @photo = Photo.find(params[:id])
  end

end
