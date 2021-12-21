# frozen_string_literal: true

class CoursePresenter < SimpleDelegator
  def stars_count
    average_rating.to_i
  end

  def course_ratings
    @course_ratings ||= reviews.average(:rating)
  end

  def star_rating(rating)
    return 0 if review_count.zero?

    reviews.where(rating: rating).count.fdiv(review_count) * 100
  end

  def review_count
    @review_count ||= reviews.count
  end
end
