class CreateLikes < ActiveRecord::Migration[7.0]
  def change
    create_table :likes do |t|
      t.references :author_id, null: false, foreign_key: true
      t.references :post_id, null: false, foreign_key: true

      t.timestamps
    end
    add_foreign_key :likes, :users, column: :author_id
    add_index :likes, :author_id

    add_foreign_key :likes, :posts, column: :post_id
    add_index :likes, :post_id
  end
end
