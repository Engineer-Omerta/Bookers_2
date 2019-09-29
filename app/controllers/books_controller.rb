class BooksController < ApplicationController
	 before_action :authenticate_user!
	 before_action :correct_user, only: [:edit, :update]
	def create
		book = Book.new(book_params)
		book.user_id = current_user.id #user_idカラムは入力出来ないので、それを埋める為の記述
		@user = current_user
		@new = book
		@books = Book.all #render:indexの処理時、indexの@booksを読み込まない為、ここで定義する必要がある
		if book.save
		flash[:notice] = "You have creatad book successfully."
		redirect_to book_path(book)
 	    else
 	    	render :index
 	    end
	end
	def index
		@books = Book.all
		@new = Book.new
		@user = current_user
		@users = User.all
	end
	def show
		@new = Book.new
		@book = Book.find(params[:id])
		@user = @book.user
		@post_comment = PostComment.new
		@favorite = Favorite.where(book_id: @book.id)
		#@favorite = Favorite.find(params[:id])このparams[:id]はbookのidが入っている状態。
		#今はfavoriteを呼び出したいからfavoriteのidを入れる必要がある
		#favorite.findの検索条件は主キーidのみ。
		#favorite.find_byは(book_id（カラム名またはid）: ○○（検索条件）)のように条件を複数指定して最初の1件のみ呼び出せる
		#favorite.whereは(book_id（カラム名）: ○○（検索条件）)のように条件を複数指定して全て呼び出せる
		#ここならfavoriteモデル内の全てのbook_idカラムの今参照している@bookのidだけのデータ全てが出てくる。
	end
	def destroy
		@book = Book.find(params[:id])
		@book.destroy
		redirect_to books_path
	end

	def edit
		@book = Book.find(params[:id])
	end
	def update
		@book = Book.find(params[:id])
	    if @book.update(book_params)
	    flash[:notice] = "You have updated user successfully."
		redirect_to book_path(@book)
		else
 	    	render :edit
	    end
	end

	private
	def book_params
		params.require(:book).permit(:title, :body)
	end
	def correct_user
       @book = Book.find(params[:id]) #editやupdateではuserを定義していないので@bookの情報からuserを特定する必要がある
    if current_user != @book.user #current_userとアクセスしているbookのユーザーIDが同じでなければリダイレクトする
       redirect_to books_path
    end
  end
end
