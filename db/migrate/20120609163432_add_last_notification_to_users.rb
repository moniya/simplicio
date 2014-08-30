class AddLastNotificationToUsers < ActiveRecord::Migration
  def change
    add_column :users, :last_notification, :datetime
    add_index :users, :last_notification

  end
end
