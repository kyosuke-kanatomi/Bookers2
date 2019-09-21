class UsersController < ApplicationController

before_action :authenticate_user!, :except => [:top, :about]

  def top

  end


  def about

  end

  def index
    @users = User.all.order(id: "DESC")
    @book = Book.new
  end

  def new
    @book = Book.new
  end

  def show
    @user = User.find(params[:id])
    @book = Book.new
    @books = @user.books.page(params[:page]).reverse_order

  end

  def edit
    @user = User.find(params[:id])
    if current_user == @user
    else
      redirect_to user_path(current_user.id)
    end
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
       flash[:notice] = "You have updated user successfully."
       redirect_to user_path(@user.id)
    else
       render("users/edit")
    end
  end


  private
  def user_params
    params.require(:user).permit(:name,:introduction,:profile_image)
  end

end
