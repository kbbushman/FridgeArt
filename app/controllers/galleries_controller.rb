class GalleriesController < ApplicationController

	before_action :get_gallery, only: [:show, :edit, :update, :destroy]

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

	def edit
	end

	def update
		if @gallery.update(update_gallery_params)
		  flash[:success] = 'Gallery Updated!'
		  redirect_to @gallery
		else
		  flash[:error] = @gallery.errors.full_messages.join('. ')
		  render :edit
		end
	end

	def destroy
		@gallery.destroy
		if @gallery.destroy
		  flash[:success] = 'Gallery Has Been Deleted Successfully.'
		  redirect_to current_user
		else
		  flash[:error] = @gallery.errors.full_messages.join('. ')
		  render :back
		end
	end


	private

	def create_gallery_params
		params.require(:gallery).permit(:gallery_name, :child_id)
	end

	def update_gallery_params
		params.require(:gallery).permit(:gallery_name)
	end

	def get_gallery
    @gallery = Gallery.find(params[:id])
  end


end
