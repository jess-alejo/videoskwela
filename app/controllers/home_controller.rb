class HomeController < ApplicationController
  skip_before_action :authenticate_user!, only: :index

  def index
    @enrolled_courses ||= recent_enrolled_courses
    @popular_courses = Course.order(enrollments_count: :desc).first(3)
    @top_rated_courses = Course.order(average_rating: :desc).first(3)
    @new_courses = Course.order(created_at: :desc).first(3)
    @course_reviews = Enrollment.reviewed.order(rating: :desc).first(3)
  end

  def activity
    @activities = PublicActivity::Activity.all.order(id: :desc)
  end

  private

  def recent_enrolled_courses
    return [] unless current_user

    Course.joins(:enrollments).where(enrollments: { student: current_user }).order(updated_at: :desc)
  end
end