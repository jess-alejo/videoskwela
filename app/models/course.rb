# frozen_string_literal: true

class Course < ApplicationRecord
  # find course by title
  extend FriendlyId
  friendly_id :title, use: :slugged

  # record activity
  include PublicActivity::Model
  tracked owner: proc { |controller, _model| controller.current_user }

  # handle state management
  include WorkflowActiverecord

  # validations
  validates :level, :language, presence: true

  validates :price, presence: true,
                    numericality: { greater_than_or_equal_to: 0 }

  validates :title, presence: true,
                    uniqueness: true,
                    length: { maximum: 70 }

  has_rich_text :description
  validates :description, presence: true,
                          length: { minimum: 5 }

  validates :short_description, presence: true,
                                length: { maximum: 300 }

  has_one_attached :image
  validates :image, attached: true,
                    content_type: { in: ['image/png', 'image/jpg', 'image/jpeg'], message: 'is not a valid image type' },
                    size: { less_than: 500.kilobytes, message: 'size should be under 500 kilobytes.' }

  belongs_to :author, class_name: 'User', foreign_key: :user_id, counter_cache: true
  # User.find_each { |user| User.reset_counters(user.id, :courses) }
  has_many :lessons, dependent: :destroy
  has_many :enrollments, dependent: :restrict_with_error
  has_many :student_lessons, through: :lessons
  has_many :course_tags, dependent: :destroy
  has_many :tags, through: :course_tags

  accepts_nested_attributes_for :lessons, reject_if: :all_blank, allow_destroy: true

  scope :popular, -> { order(enrollments_count: :desc).first(4) }
  scope :top_rated, -> { order(average_rating: :desc).first(4) }
  scope :newly_added, -> { order(created_at: :desc).first(4) }
  scope :pending_approval, -> { where(workflow_state: %w[awaiting_review being_reviewed]) }
  scope :published, -> { where(workflow_state: 'published') }

  LANGUAGES = %w[English Tagalog Russian].freeze
  LEVELS = %w[Beginner Intermediate Advanced].freeze

  workflow do
    state :draft do
      event :publish, transitions_to: :awaiting_review
    end
    state :awaiting_review do
      event :review, transitions_to: :being_reviewed
    end
    state :being_reviewed do
      event :approve, transitions_to: :published
      event :reject, transitions_to: :rejected
    end
    state :published
    state :rejected
  end

  def to_s
    title
  end

  def update_rating
    update_attribute(:average_rating, enrollments.merge(Enrollment.rated).average(:rating).to_f.round(2))
  end

  def progress(student)
    return 0 if lessons_count.zero?

    student_lessons.where(student: student).count / lessons_count.to_f * 100
  end

  def completed?(student)
    student_lessons.where(student: student).count == lessons_count
  end

  def free?
    price.zero?
  end

  def similar_courses
    course_ids = CourseTag.where(tag_id: tags.ids).pluck(:course_id).uniq
    Course.where(id: course_ids - [id])
  end

  def calculate_income
    update_column :income, enrollments.sum(:price)
    author.calculate_course_income
  end
end
