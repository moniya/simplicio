class AddRecipientIdToActivities < ActiveRecord::Migration
  def change
    add_column :activities, :recipient_id, :integer
    add_index :activities, :recipient_id

  end
end
