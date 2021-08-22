class BooksController < ApplicationController

  def index
    @book = Book.new
    @books = Book.all
    @user = current_user
  end

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    @book.save
    redirect_to book_path(@book.id)
  end

  def show
    @book = Book.find(params[:id])
    @newbook = Book.new
    @user = current_user
  end

  def edit
    @book = Book.find(params[:id])
  end

  def update
    @book = Book.find(params[:id])
  　@book.update(book_params)
    redirect_to book_path(@book.id), notice: 'Book was successfully updated.'
  end

  def destroy
  book = Book.find(params[:id])
  book.destroy
  redirect_to books_path, notice: 'Book was successfully destroyed.'
  end

  private
  def book_params
    params.require(:book).permit(:title, :body, :user_id)
  end

end
