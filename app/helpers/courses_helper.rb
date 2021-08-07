module CoursesHelper
  def enrollment_button(course)
    if current_user
      if course.author == current_user
        link_to 'View analytics', course_path(course)
      elsif current_user.enrolled?(course)
        link_to 'Continue learning', course_path(course), class: 'btn btn-md btn-outline-primary'
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
end
