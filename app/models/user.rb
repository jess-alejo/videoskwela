# frozen_string_literal: true

class User < ApplicationRecord
  extend FriendlyId
  friendly_id :email, use: :slugged

  rolify
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :trackable, :confirmable

  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }
  has_many :courses                                       # dependent: :nullify
  has_many :enrollments, foreign_key: 'student_id'        # dependent: :nullify
  has_many :student_lessons, foreign_key: 'student_id'    # dependent: :nullify

  after_create :assign_default_role

  validate :must_have_role, on: :update

  ROLES = [
    ADMIN = 'admin',
    STUDENT = 'student',
    INSTRUCTOR = 'instructor'
  ].freeze

  def assign_default_role
    add_role(User::STUDENT) if roles.blank?
  end

  def to_s
    email
  end

  def online?
    updated_at > 5.minutes.ago
  end

  def enrolled?(course)
    enrollments.where(course_id: course.id).any?
  end

  def enroll!(course, price)
    enrollments.create(course: course, price: price)
  end

  def view_lesson(lesson)
    student_lesson = student_lessons.find_or_create_by(lesson: lesson)
    student_lesson.increment!(:impressions)
  rescue ActiveRecord::RecordNotUnique
    retry
  end

  def username
    email.split(/@/).first
  end

  def admin?
    has_role? :admin
  end

  private

  def must_have_role
    errors.add(:roles, 'must have at least one role') if roles.blank?
  end
end
