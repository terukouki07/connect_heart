class CreatePosts < ActiveRecord::Migration[6.1]
  def change
    create_table :posts do |t|
      t.integer :customer_id, null: false
      t.integer :genre_id, null: false
      t.string :name, null: false
      t.string :sex, null: false
      t.integer :age, null: false
      t.text :body, null: false
      t.text :character, null: false
      t.integer :status, null: false
      t.timestamps
    end
  end
end
