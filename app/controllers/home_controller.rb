class HomeController < ApplicationController
  skip_before_action :authenticate_user!, only: :index

  def index
    @enrolled_courses ||= recent_enrolled_courses
    @popular_courses = Course.popular
    @top_rated_courses = Course.top_rated
    @new_courses = Course.newly_added
    @course_reviews = Enrollment.reviewed.latest_good_reviews
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