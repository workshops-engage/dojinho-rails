class FavoritesController < ApplicationController
  before_filter :authenticate_user!

  def index
    @favorites = current_user.favorites
  end

  def new
    @favorite = Favorite.new
    @movies = Movie.all
  end

  def create
    @favorite = current_user.favorites.new(params[:favorite])
    if @favorite.save
      return redirect_to favorites_path
    end
  end
end
