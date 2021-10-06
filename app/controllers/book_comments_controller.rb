class BookCommentsController < ApplicationController

  def create
    @book = Book.find(params[:book_id])
    # comment = current_user.book_comments.new(book_comment_params)
    comment = BookComment.new(book_comment_params)
    comment.user_id = current_user.id
    comment.book_id = @book.id
    if comment.save
      # redirect_back(fallback_location: root_path)
    else
      @newbook = Book.new
      @user = @book.user
      @book_comment = BookComment.new
      render 'books/show'
    end
  end

  def destroy
    @book = Book.find(params[:book_id])
    BookComment.find_by(id: params[:id]).destroy
    # redirect_back(fallback_location: root_path)
  end


  private

  def book_comment_params
    params.require(:book_comment).permit(:comment)
  end

end
