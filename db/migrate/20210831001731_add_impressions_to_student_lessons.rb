class AddImpressionsToStudentLessons < ActiveRecord::Migration[6.1]
  def change
    add_column :student_lessons, :impressions, :integer, default: 0, null: false
  end
end
