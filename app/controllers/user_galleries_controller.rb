class UserGalleriesController < ApplicationController

	before_action :get_user
	before_action :get_child, only: [:new, :create]
	before_action :get_gallery, except: [:index, :new, :create]
	before_action :logged_in?, except: [:show]
	before_action :account_owner?, except: [:show]


	def index
		@children = @user.children
		@galleries = @user.galleries
	end

	def show
		@photo = @gallery.photos
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
		  redirect_to all_child_path(@user, @gallery.child)
		else
		  flash[:error] = @gallery.errors.full_messages.join('. ')
		  render :new
		end
	end

	def edit
	end

	def update
		if @gallery.update(gallery_params)
		  flash[:success] = 'Gallery Updated!'
		  redirect_to all_child_path(@user, @gallery.child)
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

	def get_child
    @child = Child.find(params[:id])
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
