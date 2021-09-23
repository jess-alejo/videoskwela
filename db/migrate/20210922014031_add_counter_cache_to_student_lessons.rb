class AddCounterCacheToStudentLessons < ActiveRecord::Migration[6.1]
  def change
    add_column :lessons, :student_lessons_count, :integer, null: false, default: 0
    add_column :users,   :student_lessons_count, :integer, null: false, default: 0
  end
end
