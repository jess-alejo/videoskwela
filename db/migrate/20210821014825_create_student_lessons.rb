class CreateStudentLessons < ActiveRecord::Migration[6.1]
  def change
    create_table :student_lessons do |t|
      t.references :student, null: false, foreign_key: { to_table: :users }
      t.references :lesson, null: false, foreign_key: true

      t.timestamps
    end

    add_index :student_lessons, %i[student_id lesson_id], unique: true
  end
end
