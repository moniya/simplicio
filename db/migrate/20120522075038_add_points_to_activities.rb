class AddPointsToActivities < ActiveRecord::Migration
  def change
    add_column :activities, :points, :integer
    add_index :activities, :points

  end
end
