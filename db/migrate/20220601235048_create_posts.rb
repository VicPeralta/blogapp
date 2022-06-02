class CreatePosts < ActiveRecord::Migration[7.0]
  def change
    create_table :posts do |t|
      t.integer :author_id
      t.string :title
      t.text :text
      t.integer :commentsCounter
      t.integer :likesCounter

      t.timestamps
    end
    add_foreign_key :posts, :users, column: :author_id, primary_key: 'id'
    add_index :posts, :author_id
  end
end
