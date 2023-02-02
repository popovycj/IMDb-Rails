class CreateRatings < ActiveRecord::Migration[7.0]
  def change
    create_table :ratings do |t|
      t.integer :user_id
      t.integer :movie_id
      t.integer :score

      t.timestamps
    end

    add_index :ratings, [:user_id, :movie_id]
  end
end
