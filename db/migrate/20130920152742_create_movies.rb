class CreateMovies < ActiveRecord::Migration
  def change
    create_table :movies do |t|
      t.string :title
      t.string :title_index
      t.string :director
      t.integer :year
      t.integer :current_rating
      t.integer :skandies_year
      t.boolean :short, default: false

      t.timestamps
    end
    add_index :movies, [:title_index]
    add_index :movies, [:year, :current_rating]
    add_index :movies, [:skandies_year, :current_rating]
    add_index :movies, [:skandies_year, :title_index]
  end
end
