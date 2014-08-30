class CreateViews < ActiveRecord::Migration
  def change
    create_table :views do |t|
      t.references :user
      t.references :question

      t.timestamps
    end
    add_index :views, :user_id
    add_index :views, :question_id
  end
end
