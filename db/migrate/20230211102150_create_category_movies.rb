class CreateCategoryMovies < ActiveRecord::Migration[7.0]
  def change
    create_table :category_movies do |t|
      t.references :category, null: false, foreign_key: true
      t.references :movie, null: false, foreign_key: true

      t.timestamps
    end
  end
end
