class StudentLesson < ApplicationRecord
  belongs_to :student, class_name: 'User'
  belongs_to :lesson

  validates :student, :lesson, presence: true
  validates_uniqueness_of :student, scope: :lesson
end
