class FavoritesController < ApplicationController
	def create
		book = Book.find(params[:book_id]) #
		favorite = current_user.favorites.new(book_id: book.id)
		#右辺の本のidを左辺のPostCommentのカラムに代入する。これで4つ中id以外のカラムが揃いidが作成され、saveできる
		favorite.save
		redirect_to book_path(book)
	end
	def destroy
		book = Book.find(params[:book_id])
		favorite = current_user.favorites.find_by(book_id: book.id) #？？？
		favorite.destroy
		redirect_to book_path(book)
	end
	def show
		@user = current_user
		@new = Book.new
		book = Book.find(params[:book_id]) #paramsとはそのページにアクセスした時のURLの数字を参照する
		@favorites = Favorite.where(book_id: book.id)
		#favoriteモデルのbook_idカラムが分かればそれに紐付くbookのidを参照し、そこからユーザーのidも分かるという考え方
	end
end
