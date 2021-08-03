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
  has_many :courses
  has_many :enrollments, foreign_key: 'student_id'

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
  private

  def must_have_role
    errors.add(:roles, 'must have at least one role') if roles.blank?
  end
end
