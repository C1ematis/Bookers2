class BooksController < ApplicationController

    before_action :correct_user, only: [:edit, :update]
    helper_method :sort_column, :sort_direction

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    tag_list = params[:book][:tag_name].split(",")
    if @book.star.blank?
      @book.star= 0
    end
    if @book.save
      @book.tag_save(tag_list)
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
    @tag_list = @book.tags.all
    @book_comment = BookComment.new
  end

  def index
    @user = User.find(current_user.id)
    if params[:word]
      @word = params[:word]
      @search_kind = params[:search_kind]
      if @search_kind == 'タイトル'
        @books = Book.search(@word).order("#{sort_column} #{sort_direction}")
        if @books.blank?
          @books = "no_search"
        end
      else
        @tag = Tag.search(@word)
        @books = @tag.any? ? @tag[0].books.order("#{sort_column} #{sort_direction}") : "no_search"
      end
    else
      @books = Book.order("#{sort_column} #{sort_direction}")
    end
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
    @tag_list = @book.tags.pluck(:tag_name).join(",")
  end

  def update
    @book = Book.find(params[:id])
    tag_list = params[:book][:tag_name].split(",")
    if @book.update(book_params)
      @book.tag_save(tag_list)
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
