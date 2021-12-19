# frozen_string_literal: true

class CoursePresenter < SimpleDelegator
  def stars_count
    average_rating.to_i
  end

  def raters_count
    course_ratings.count
  end

  def course_ratings
    @course_ratings ||= enrollments.rated
  end

  def star_rating(rating)
    return 0 if total_count_course_rating.zero?

    course_ratings.where(rating: rating).count.fdiv(total_count_course_rating) * 100
  end

  def total_count_course_rating
    @total_count_course_rating ||= course_ratings.count
  end
end
