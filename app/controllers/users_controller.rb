class UsersController < ApplicationController
  
  def index
    @users = User.all
  end  

  def show
    @user = User.find(params[:id])
    @favorites = @user.favorites
  end

end