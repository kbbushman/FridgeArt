class PhotosController < ApplicationController

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

end
