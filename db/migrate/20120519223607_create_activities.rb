class CreateActivities < ActiveRecord::Migration
  def change
    create_table :activities do |t|
      t.string :username
      t.string :email
      t.string :kind
      t.references :user
      t.string :data

      t.timestamps
    end
    add_index :activities, :user_id
  end
end
