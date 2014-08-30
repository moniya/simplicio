class AddViewsCountToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :views_count, :integer
    add_index :posts, :views_count

    Post.reset_column_information
    Question.find_each do |q|
      Question.update_counters(q.id, views_count: q.views.length)
    end
  end
end
