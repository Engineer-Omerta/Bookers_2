class BooksController < ApplicationController
	def create
		book = Book.new(book_params)
		book.user_id = current_user.id #user_idカラムは入力出来ないので、それを埋める為の記述
		book.save
		redirect_to books_path
	end
	def index
		@books = Book.all
		@book = Book.new
	end
	def show
	end

	private
	def book_params
		params.require(:book).permit(:title, :body)
	end
end
