class AddScoreToUsers < ActiveRecord::Migration
  def change
    add_column :users, :score, :integer, default: 0
    add_index :users, :score

  end
end
