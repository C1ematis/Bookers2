class BooksController < ApplicationController

    before_action :correct_user, only: [:edit, :update]
    helper_method :sort_column, :sort_direction

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.star.blank?
      @book.star= 0
    end
    if @book.save
      redirect_to book_path(@book.id), notice: "You have created book successfully."
    else
      @user = User.find(current_user.id)
      @books = Book.all
      render :index
    end
  end

  def show
    @book = Book.find(params[:id])
    @user = User.find(@book.user.id)
    @book_comment = BookComment.new
  end

  def index
    @user = User.find(current_user.id)
    @books = Book.order("#{sort_column} #{sort_direction}")
    # @books = Book.joins(:favorites).group("favorites.book_id").order(Arel.sql(:sort))
  end

  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : 'asc'
  end

  def sort_column
    Book.column_names.include?(params[:sort]) ? params[:sort] : 'created_at'
  end

  def edit
    @book = Book.find(params[:id])
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      redirect_to book_path(@book.id), notice: "You have updated book successfully."
    else
      render :edit
    end
  end

  def destroy
    @book = Book.find(params[:id])
    @book.destroy
    redirect_to books_path
  end

private
  def book_params
    params.require(:book).permit(:title, :body, :star)
  end

  def correct_user
    book = Book.find(params[:id])
    if current_user.id != book.user.id
      redirect_to books_path
    end
  end

end
