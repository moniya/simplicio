class AddTaggingsCountToTags < ActiveRecord::Migration
  def change
    add_column :tags, :taggings_count, :integer
    add_index :tags, :taggings_count

    Tag.reset_column_information
    Tag.find_each do |t|
      Tag.update_counters(t.id, taggings_count: t.taggings.length)
    end
  end
end
