# frozen_string_literal: true

class Lesson < ApplicationRecord
  extend FriendlyId
  friendly_id :title, use: :slugged

  include PublicActivity::Model
  tracked owner: proc { |controller, _model| controller.current_user }

  include RankedModel
  ranks :row_order, with_same: :course_id

  has_rich_text :content

  has_one_attached :video
  validates :video, content_type: ['video/mp4'],
                    size: { less_than: 50.megabytes, message: 'should be under 50 megabytes' }

  has_one_attached :video_thumbnail
  validates :video_thumbnail, content_type: ['image/png', 'image/jpg', 'image/jpeg'],
                              size: { less_than: 500.kilobytes, message: 'should be under 500 kilobytes' }
  # presence: { unless: -> { video.blank? } }

  belongs_to :course, counter_cache: true
  # Course.find_each { |course| Course.reset_counters(course.id, :lessons) }

  has_many :student_lessons, dependent: :destroy

  validates :title, presence: true,
                    uniqueness: { scope: :course_id },
                    length: { maximum: 70 }

  validates :content, presence: true

  def to_s
    title
  end

  def viewed_by?(student)
    student_lessons.find_by(student: student).present?
  end

  def previous_lesson
    course.lessons.where('row_order < ?', row_order).order(:row_order).last
  end

  def next_lesson
    course.lessons.where('row_order > ?', row_order).order(:row_order).first
  end
end
