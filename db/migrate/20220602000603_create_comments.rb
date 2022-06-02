class CreateComments < ActiveRecord::Migration[7.0]
  def change
    create_table :comments do |t|
      t.integer :user_id
      t.integer :post_id
      t.string :text

      t.timestamps
    end
    add_foreign_key :comments, :users
    add_foreign_key :comments, :posts
    add_index :comments, :user_id
    add_index :comments, :post_id
  end
end
