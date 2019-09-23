class UsersController < ApplicationController
   before_action :authenticate_user!
  def index
  	  @users = User.all
      @user = current_user #@がついてる@userにcurrent_user.idの.idをつけたらエラーが出る
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
  def update
  	  user = User.find(params[:id])
  	  user.update(user_params)
  	  redirect_to user_path
  end
  def show
      @user = User.find(params[:id])
      @books = @user.books #こう記述することで@userのbooksのみを参照する
      @book = Book.new
  end
  private
  def user_params
  	  params.require(:user).permit(:name, :introduction, :profile_image)
  end
end
