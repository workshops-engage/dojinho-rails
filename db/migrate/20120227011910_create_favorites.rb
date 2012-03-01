class CreateFavorites < ActiveRecord::Migration
  def change
    create_table :favorites do |t|
      t.references :user, null: false
      t.references :movie, null: false
      t.integer :rank, null: false

      t.timestamps
    end
    add_index :favorites, :user_id
    add_index :favorites, :movie_id
    add_foreign_key :favorites, :users
    add_foreign_key :favorites, :movies
    add_index :favorites, [:user_id, :movie_id], unique: true
    add_index :favorites, [:user_id, :rank], unique: true
  end
end
