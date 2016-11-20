class ChildrenController < ApplicationController

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


	private

	def create_child_params
		params.require(:child).permit(:child_name)
	end

end
