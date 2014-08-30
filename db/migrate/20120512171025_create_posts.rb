class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string "title"
      t.text "text"
      t.string "type"
      t.integer "question_id"

      t.timestamps
    end

    add_index :posts, :title, unique: true
    add_index :posts, :question_id
    add_index :posts, :type

  end
end
