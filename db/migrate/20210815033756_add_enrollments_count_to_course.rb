class AddEnrollmentsCountToCourse < ActiveRecord::Migration[6.1]
  def up
    add_column :courses, :enrollments_count, :integer, null: false, default: 0

    Course.find_each { |course| Course.reset_counters(course.id, :enrollments) }
  end

  def down
    remove_column :courses, :enrollments_count
  end
end
