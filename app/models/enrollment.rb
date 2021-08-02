class Enrollment < ApplicationRecord
  belongs_to :course
  belongs_to :student, class_name: 'User', foreign_key: 'student_id'

  validates_uniqueness_of :student_id, scope: :course_id
  validates_uniqueness_of :course_id, scope: :student_id

  validate :cant_enroll_to_own_course, on: :create

  private

  def cant_enroll_to_own_course
    errors.add(:base, 'You can not enroll to your own course') if course && course.author == student
  end
end
