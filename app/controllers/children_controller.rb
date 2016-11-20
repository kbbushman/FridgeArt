class ChildrenController < ApplicationController

	before_action :get_child, only: [:show]
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

	def get_child
    @child = Child.find(params[:id])
  end

	def destroy_child
    @child = Child.find(params[:child_id])
  end

end
