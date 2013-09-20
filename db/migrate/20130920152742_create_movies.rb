class CreateMovies < ActiveRecord::Migration
  def change
    create_table :movies do |t|
      t.string :title
      t.string :title_index
      t.string :director
      t.string :year
      t.string :skandies_year
      t.boolean :short, default: false

      t.timestamps
    end
    add_index :movies, [ :year ]
    add_index :movies, [ :skandies_year ]
    add_index :movies, [ :skandies_year, :title_index ]
  end
end
