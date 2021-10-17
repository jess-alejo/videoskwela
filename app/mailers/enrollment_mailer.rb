# frozen_string_literal: true

class EnrollmentMailer < ApplicationMailer
  default from: "notification@videoskwela.com"

  def student(enrollment)
    @enrollment = enrollment
    @course = enrollment.course
    mail(to: @enrollment.student.email, subject: "#{@enrollment.student.username}, welcome to #{@course}")
  end

  def author(enrollment)
    @enrollment = enrollment
    @course = enrollment.course
    mail(to: @course.author.email,
         subject: "#{@course.author.username}, you have a new student on your course #{@course}")
  end
end
