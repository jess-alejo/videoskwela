class Lesson < ApplicationRecord
  extend FriendlyId
  friendly_id :title, use: :slugged

  include PublicActivity::Model
  tracked owner: proc { |controller, _model| controller.current_user }

  has_rich_text :content
  belongs_to :course, counter_cache: true
  # Course.find_each { |course| Course.reset_counters(course.id, :lessons) }

  has_many :student_lessons

  validates :title, presence: true
  validates :content, presence: true

  def to_s
    title
  end

  def viewed_by?(student)
    student_lessons.find_by(student: student).present?
  end
end
