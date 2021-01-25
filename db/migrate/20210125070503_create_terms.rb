class CreateTerms < ActiveRecord::Migration[6.0]
  def change
    create_table :terms do |t|
      t.integer :term_type, null: false
      t.integer :each_id, null: false
      t.integer :lesson, null: false
      t.text :english, null: false
      t.text :japanese, null: false
      t.timestamps
    end
  end
end
