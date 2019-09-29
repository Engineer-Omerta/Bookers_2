class PostCommentsController < ApplicationController
	def create
		book = Book.find(params[:book_id]) #なぜparams[:id]ではだめなのか→routesに:book_idとあるから。仮に:idとすると違うbookを探してしまう
		#book_idはPostCommentのカラム　PostCommentを呼び出す為には親のbook、それに紐付くPostCommentのbook_idが必要
		comment = current_user.post_comments.new(post_comment_params)
		comment.book_id = book.id
		comment.save
		redirect_to book_path(book)
	end
	def destroy
		book = Book.find(params[:book_id])
		bookd = book.post_comments.find(params[:id])
		bookd.destroy
		redirect_to book_path(book)
	end
	def edit #editを入れたらupdateも定義しないとエラーになる
		@book = Book.find(params[:book_id])
		@post_comment = @book.post_comments.find(params[:id])
	end
	def update
		@book = Book.find(params[:book_id])
		@post_comment = @book.post_comments.find(params[:id])
		@post_comment.update(post_comment_params)
		redirect_to book_path(@book)
	end

	private
	def post_comment_params
		params.require(:post_comment).permit(:user_id,
			                                 :book_id,
			                                 :comment)
	end
end
