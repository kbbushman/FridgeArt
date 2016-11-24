class ChildrenController < ApplicationController

	before_action :get_child, only: [:show, :edit, :update]
	before_action :destroy_child, only: [:destroy]


	def index
		@children = Child.all
	end

	def new
		@child = Child.new
	end

	def create
		@child = User.find(session[:user_id])
		.children
		.create(create_child_params)
		if @child.save
		  flash[:success] = 'Your Child Has Been Added.'
		  redirect_to current_user
		else
		  flash[:error] = @child.errors.full_messages.join('. ')
		  render :new
		end
	end

	def show
		@galleries = @child.galleries
	end

	def edit
	end

	def update
		if @child.update(update_child_params)
		  flash[:success] = 'Child Updated!'
		  redirect_to current_user
		else
		  flash[:error] = @child.errors.full_messages.join('. ')
		  render :edit
		end
	end

	def destroy
		@child.destroy
		if @child.destroy
		  flash[:success] = 'Your Child Has Been Deleted Successfully.'
		  redirect_to current_user
		else
		  flash[:error] = @child.errors.full_messages.join('. ')
		  render :back
		end
	end


	private

	def create_child_params
		params.require(:child).permit(:child_name)
	end

  def update_child_params
    params.require(:child).permit(:child_name)
  end

	def get_child
    @child = Child.find(params[:id])
  end

	def destroy_child
    @child = Child.find(params[:child_id])
  end

end
