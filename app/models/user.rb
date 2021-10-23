# frozen_string_literal: true

class User < ApplicationRecord
  extend FriendlyId
  friendly_id :email, use: :slugged

  rolify
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :trackable, :confirmable,
         :omniauthable, omniauth_providers: [:google_oauth2]

  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }
  has_many :courses                                       # dependent: :nullify
  has_many :enrollments, foreign_key: 'student_id'        # dependent: :nullify
  has_many :student_lessons, foreign_key: 'student_id'    # dependent: :nullify

  has_many :comments, dependent: :nullify

  after_create :assign_default_role
  after_create do
    UserMailer.new_user(self).deliver_later
  end

  validate :must_have_role, on: :update

  ROLES = [
    ADMIN = 'admin',
    STUDENT = 'student',
    INSTRUCTOR = 'instructor'
  ].freeze

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

  def avatar_url
    hash = Digest::MD5.hexdigest(email)
    "http://www.gravatar.com/avatar/#{hash}"
  end

  def self.from_omniauth(access_token)
    data = access_token.info
    user = User.where(email: data['email']).first

    unless user
        user = User.create(
           email: data['email'],
           password: Devise.friendly_token[0,20],
           confirmed_at: Time.now
        )
    end
    user
  end

  private

  def must_have_role
    errors.add(:roles, 'must have at least one role') if roles.blank?
  end

  def assign_default_role
    add_role(User::STUDENT) if roles.blank?
  end
end
