class HomeController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[index privacy_policy]
  before_action :authorize_user, except: %i[index privacy_policy]

  def index
    @enrolled_courses ||= recent_enrolled_courses
    @popular_courses = Course.published.popular
    @top_rated_courses = Course.published.top_rated
    @new_courses = Course.published.newly_added
    @course_reviews = Enrollment.reviewed.latest_good_reviews
    @popular_tags = Tag.order(course_tags_count: :desc).limit(10)
  end

  def activity
    @pagy, @activities = pagy(PublicActivity::Activity.all.order(id: :desc))
  end

  def analytics; end

  def privacy_policy; end

  private

  def recent_enrolled_courses
    return [] unless current_user

    Course.joins(:enrollments).where(enrollments: { student: current_user }).order(updated_at: :desc).take(4)
  end

  def authorize_user
    return if current_user.has_role? :admin

    redirect_to root_path, alert: "You are not allowed to access the #{action_name.titleize} page"
  end
end