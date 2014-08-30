class AddAnswersCountToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :answers_count, :integer, default: 0
    add_index :posts, :answers_count


    Post.reset_column_information
    Question.find_each do |q|
      Question.update_counters(q.id, answers_count: q.answers.length)
    end
  end
end
