class UserChildrenController < ApplicationController

	before_action :get_user
	before_action :get_child, only: [:show, :edit, :update, :destroy]
	before_action :logged_in?
	before_action :account_owner?

	def index
		@children = @user.children
	end

	def show
		@galleries = @child.galleries
	end

	def new
		@child = Child.new
	end

	def create
		@child = @user
						 .children
						 .create(child_params)
		if @child.save
		  flash[:success] = 'Child Added Successfully.'
		  redirect_to all_children_path
		else
		  flash[:error] = @child.errors.full_messages.join('. ')
		  render :new
		end
	end

	def edit
	end

	def update
		if @child.update(child_params)
		  flash[:success] = 'Child Updated Successfully.'
		  redirect_to all_children_path
		else
		  flash[:error] = @child.errors.full_messages.join('. ')
		  render :edit
		end
	end

	def destroy
		@child.destroy
		if @child.destroy
		  flash[:success] = 'Child Deleted Successfully.'
		  redirect_to all_children_path
		else
		  flash[:error] = @child.errors.full_messages.join('. ')
		  render :back
		end
	end


	private

	def get_user
    @user = User.friendly.find(params[:user_id])
  end

	def get_child
    @child = Child.find(params[:id])
  end

  def child_params
  	params.require(:child).permit(:child_name)
  end

  def account_owner?
    if current_user != @user
      flash[:error] = 'You do not have permission.'
      redirect_to current_user
    end
  end

end
