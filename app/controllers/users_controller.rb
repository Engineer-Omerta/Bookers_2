class UsersController < ApplicationController
   before_action :authenticate_user!
   before_action :correct_user, only: [:edit, :update]
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
  	  @user = User.find(params[:id])
  	  if @user.update(user_params)
      flash[:notice] = "You have updated user successfully."
  	  redirect_to user_path
      else
        render :edit
      end
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
  def correct_user
    @user = User.find(params[:id])
    if current_user != @user
       redirect_to user_path(current_user)
    end
  end
end
