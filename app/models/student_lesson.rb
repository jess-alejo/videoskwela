class StudentLesson < ApplicationRecord
  belongs_to :student, class_name: 'User', counter_cache: true
  belongs_to :lesson, counter_cache: true

  validates :student, :lesson, presence: true
  validates_uniqueness_of :student, scope: :lesson
end
