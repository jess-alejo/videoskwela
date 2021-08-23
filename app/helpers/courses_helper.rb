module CoursesHelper
  def enrollment_button(course)
    if current_user
      if course.author == current_user
        link_to 'View analytics', course_path(course)
      elsif current_user.enrolled?(course)
        link_to course_path(course), class: 'btn btn-md btn-outline-primary' do
          "<i class='fa fa-spinner'></i>".html_safe + ' ' +
            number_to_percentage(course.progress(current_user), precision: 0) + " " +
            "Complete"
        end
      elsif course.price > 0
        link_to number_to_currency(course.price), new_course_enrollment_path(course), class: 'btn btn-lg btn-success'
      else
        link_to 'Free', new_course_enrollment_path(course), class: 'btn btn-md btn-success'
      end
      # logic to buy course
    else
      link_to 'Check price', course_path(course), class: 'btn btn-md btn-success'
    end
  end

  def review_button(course)
    if current_user
      enrollment = course.enrollments.find_by(student: current_user)
      return unless enrollment

      if enrollment.rating || enrollment.review
        link_to 'Thanks for the review', enrollment_path(enrollment), class: 'btn btn-md btn-outline-warning'
      else
        link_to 'Leave a review', edit_enrollment_path(enrollment), class: 'btn btn-md btn-outline-warning'
      end
    end
  end

  def show_star_rating(rating)
    full_star_icon_name = 'fa fa-star'
    half_star_icon_name = 'fas fa-star-half-alt'
    zero_star_icon_name = 'far fa-star'

    rating_round_point5 = (rating * 2).round / 2.0

    stars = (1..5).map do |i|
      next(full_star_icon_name) if i <= rating_round_point5
      next(half_star_icon_name) if rating_round_point5 + 0.5 == i

      zero_star_icon_name
    end

    stars.collect { |star| content_tag(:i, nil, class: star) }.join.html_safe
  end
end
