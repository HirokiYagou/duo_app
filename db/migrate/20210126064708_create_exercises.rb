class CreateExercises < ActiveRecord::Migration[6.0]
  def change
    create_table :exercises do |t|
      t.integer :e_j, null: false
      t.integer :score, null: false
      t.references :user, null: false, foreign_key: true
      t.references :term, null: false, foreign_key: true
      t.timestamps
    end
  end
end
