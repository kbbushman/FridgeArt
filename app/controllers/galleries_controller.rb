class GalleriesController < ApplicationController

	before_action :get_user
	before_action :get_child
	before_action :get_gallery, only: [:show, :edit, :update, :destroy]
	before_action :logged_in?
	before_action :account_owner?

	def index
		@galleries = @child.galleries
	end

	def new
		@gallery = Gallery.new
	end

	def create
		@gallery = @child
							 .galleries
							 .new(gallery_params)

		@gallery.user_id = @user.id
		@gallery.save

		if @gallery.save
		  flash[:success] = 'Gallery Created Successfully.'
		  redirect_to user_child_gallery_path(@user, @child, @gallery)
		else
		  flash[:error] = @gallery.errors.full_messages.join('. ')
		  render :new
		end
	end

	def show
		@photo = @gallery.photos
	end

	def edit
	end

	def update
		if @gallery.update(gallery_params)
		  flash[:success] = 'Gallery Updated!'
		  redirect_to user_child_galleries_path(@user, @child)
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

	def gallery_params
		params.require(:gallery).permit(:gallery_name)
	end

	def get_user
    @user = User.friendly.find(params[:user_id])
  end

	def get_child
    @child = Child.find(params[:child_id])
  end

	def get_gallery
    @gallery = Gallery.find(params[:id])
  end

  def account_owner?
    if current_user != Child.find(params[:child_id]).user
      flash[:error] = 'You do not have permission.'
      redirect_to current_user
    end
  end


end
