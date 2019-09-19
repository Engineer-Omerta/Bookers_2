class UsersController < ApplicationController
  def index
  	  @users = User.all
	  @book = Book.new
  end
  def create
	  book = Book.new(book_params)
      book.user_id = current_user.id #user_idカラムは入力出来ないので、それを埋める為の記述
	  book.save
	  redirect_to books_path
  end

  def edit
  	  @user = User.find(params[:id])
  end
end
