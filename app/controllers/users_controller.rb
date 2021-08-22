class UsersController < ApplicationController

  def index
    @book = Book.new
    @users = User.all
    @user = current_user
  end

  def show
    @newbook = Book.new
    @user = User.find(params[:id])
    @books = @user.books.reverse_order
  end

  def edit
  end

end
