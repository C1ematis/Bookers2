class SearchesController < ApplicationController
  
  def search
    @word = params[:word]
    @range = params[:range]
    if @range == "User"
      @users = User.looks(params[:way], params[:word])
    else
      @books = Book.looks(params[:way], params[:word])
    end
  end

end
