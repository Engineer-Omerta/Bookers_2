class BooksController < ApplicationController
	 before_action :authenticate_user!
	def create
		book = Book.new(book_params)
		book.user_id = current_user.id #user_idカラムは入力出来ないので、それを埋める為の記述
		book.save
		redirect_to books_path
	end
	def index
		@books = Book.all
		@book = Book.new
		@user = current_user
		@users = User.all
	end
	def show
		@user = current_user
		
		@book = Book.find(params[:id])
	end
	def destroy
		@book = Book.find(params[:id])
		@book.destroy
		redirect_to user_path(current_user.id)
	end

	private
	def book_params
		params.require(:book).permit(:title, :body)
	end
end
