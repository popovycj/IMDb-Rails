class AddDurationAndActorsFieldsToMovies < ActiveRecord::Migration[7.0]
  def change
    add_column :movies, :duration, :string
    add_column :movies, :actors, :string
  end
end
