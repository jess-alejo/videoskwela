class HomeController < ApplicationController
  skip_before_action :authenticate_user!, only: :index

  def index
    @popular_courses = Course.first(3);
    @top_rated_courses = Course.where(id: Course.all.pluck(:id).shuffle.sample(3))
    @new_courses = Course.order(created_at: :desc).first(3)
  end

  def activity
    @activities = PublicActivity::Activity.all.order(id: :desc)
  end
end