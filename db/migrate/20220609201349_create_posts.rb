class CreatePosts < ActiveRecord::Migration[7.0]
  def change
    create_table :posts do |t|
      t.references :author_id, null: false, foreign_key: true
      t.string :title
      t.text :text
      t.integer :comments_counter
      t.integer :likes_counter

      t.timestamps
    end
    add_foreign_key :posts, :users, column: :author_id
    add_index :posts, :author_id
  end
end
