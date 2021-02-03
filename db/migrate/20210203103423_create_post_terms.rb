class CreatePostTerms < ActiveRecord::Migration[6.0]
  def change
    create_table :post_terms do |t|
      t.references :post, foreign_key: true
      t.references :term, foreign_key: true
      t.timestamps
    end
  end
end
