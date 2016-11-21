class GalleriesController < ApplicationController

	def index
		@galleries = Gallery.all
	end

	def new
		@gallery = Gallery.new
	end

	def create
		@gallery = current_user
			.galleries
			.new(create_gallery_params)

		@gallery.save

		if @gallery.save
		  flash[:success] = 'Your Gallery Has Been Created.'
		  redirect_to current_user
		else
		  flash[:error] = @gallery.errors.full_messages.join('. ')
		  render :new
		end
	end

	def show
	end


	private

	def create_gallery_params
		params.require(:gallery).permit(:gallery_name, :child_id)
	end


end
