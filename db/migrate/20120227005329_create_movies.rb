class CreateMovies < ActiveRecord::Migration
  def change
    create_table :movies do |t|
      t.string :imdb_id, null: false
      t.string :url, null: false
      t.string :title, null: false

      t.timestamps
    end
    add_index :movies, :imdb_id, unique: true
  end
end