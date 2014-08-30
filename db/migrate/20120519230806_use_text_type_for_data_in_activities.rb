class UseTextTypeForDataInActivities < ActiveRecord::Migration
  def up
    change_table :activities do |t|
      t.remove :data
      t.text :data
    end
  end

  def down
    change_table :activities do |t|
      t.remove :data
      t.string :data
    end
  end
end
