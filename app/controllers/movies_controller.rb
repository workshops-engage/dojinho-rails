class MoviesController < ApplicationController
  def index
    @movies = Movie.all
  end

  def show
    @movie = Movie.find(params[:id])
    @movie.imdb = Imdb::Movie.new(@movie.imdb_id)
  end
end
