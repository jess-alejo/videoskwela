class AddCounterCacheFields < ActiveRecord::Migration[6.1]
  def up
    add_column :courses, :lessons_count, :integer, null: false, default: 0
    add_column :users, :courses_count, :integer, null: false, default: 0
    add_column :users, :enrollments_count, :integer, null: false, default: 0

    Course.find_each { |course| Course.reset_counters(course.id, :lessons) }
    User.find_each { |user| User.reset_counters(user.id, :courses, :enrollments) }
  end

  def down
    remove_column :courses, :lessons_count
    remove_column :users, :courses_count
    remove_column :users, :enrollments_count
  end
end
