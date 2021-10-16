# frozen_string_literal: true

class EnrollmentMailer < ApplicationMailer
  default from: "notification@videoskwela.com"

  def new_enrollment(enrollment)
    @enrollment = enrollment
    @course = enrollment.course
    mail(to: @enrollment.student.email, subject: "#{@enrollment.student.username}, welcome to #{@course}")
  end
end
