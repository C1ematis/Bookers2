class SearchesController < ApplicationController

  def search
    @word = params[:word]
    @range = params[:range]
    @user = User.find(current_user.id)
    if @range == "User"
      @users = User.looks(params[:way], params[:word])
    else
      @books = Book.looks(params[:way], params[:word])
    end
  end

end
