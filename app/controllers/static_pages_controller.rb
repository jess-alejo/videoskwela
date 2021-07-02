class StaticPagesController < ApplicationController
  def landing_page
    @popular_courses = Course.first(3);
    @top_rated_courses = Course.where(id: Course.all.pluck(:id).shuffle.sample(3))
    @new_courses = Course.order(created_at: :desc).first(3)
  end

  def privacy_policy
  end
end
