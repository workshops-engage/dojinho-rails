class AddPointsToMovies < ActiveRecord::Migration
  def change
    add_column :movies, :points, :integer, null: false, default: 0

  end
end
