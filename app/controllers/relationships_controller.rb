class RelationshipsController < ApplicationController

  def create
    current_user.follow(params[:user_id])
    redirect_to request.referer
  end

  def destroy
    current_user.unfollow(params[:user_id])
    redirect_to request.referer
  end

  def followings
    user = User.find(params[:user_id])
    @users = user.follower_user
    @user = User.find(current_user.id)
  end

  def followers
    user = User.find(params[:user_id])
    @users = user.followed_user
    @user = User.find(current_user.id)
  end

end
