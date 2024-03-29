class BooksController < ApplicationController

before_action :authenticate_user!

  def index
    @books = Book.all.order(id: "DESC")
    @book = Book.new
  end

  def new
    @book = Book.new
  end

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
       flash[:notice] = "You have creatad book successfully."
       redirect_to book_path(@book)
    else
       @books = Book.all.order(id: "DESC")
       render("books/index")
    end
  end

  def show
    @books = Book.find(params[:id])
    @user = @books.user
    @book = Book.new
  end

  def edit
    @book = Book.find(params[:id])
    @user = @book.user
    if current_user == @user
    else
      redirect_to books_path
    end
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
       flash[:notice] = "You have updated book successfully."
       redirect_to book_path(@book.id)
    else
       render("books/edit")
    end
  end

  def destroy
    book = Book.find(params[:id])
    book.destroy
    redirect_to books_path
  end

private
  def book_params
    params.require(:book).permit(:title, :body, :user_id)
  end

end
