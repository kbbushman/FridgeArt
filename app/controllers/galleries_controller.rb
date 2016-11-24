class GalleriesController < ApplicationController

	before_action :get_child, only: [:new, :show, :edit, :update]
	before_action :get_gallery, only: [:show, :edit, :update, :destroy]

	def index
		@galleries = Child.find(params[:id]).galleries.all
	end

	def new
		@gallery = Gallery.new
	end

	def create
		@gallery = Child.find(params[:child_id])
							.galleries
							.new(gallery_params)

		@gallery.user_id = current_user.id
		@gallery.save

		if @gallery.save
		  flash[:success] = 'Your Gallery Has Been Created.'
		  redirect_to @gallery.child
		else
		  flash[:error] = @gallery.errors.full_messages.join('. ')
		  render :new
		end
	end

	def show
		@photos = @gallery.photos
	end

	def edit
	end

	def update
		if @gallery.update(gallery_params)
		  flash[:success] = 'Gallery Updated!'
		  redirect_to @gallery.child
		else
		  flash[:error] = @gallery.errors.full_messages.join('. ')
		  render :edit
		end
	end

	def destroy
		@gallery.destroy
		if @gallery.destroy
		  flash[:success] = 'Gallery Has Been Deleted Successfully.'
		  redirect_to :back
		else
		  flash[:error] = @gallery.errors.full_messages.join('. ')
		  render :back
		end
	end


	private

	def gallery_params
		params.require(:gallery).permit(:gallery_name)
	end

	def get_child
    @child = Child.find(params[:child_id])
  end

	def get_gallery
    @gallery = Gallery.find(params[:id])
  end


end
