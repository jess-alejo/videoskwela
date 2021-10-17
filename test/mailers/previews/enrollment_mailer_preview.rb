# Preview all emails at http://localhost:3000/rails/mailers/enrollment_mailer
class EnrollmentMailerPreview < ActionMailer::Preview
  def student
    EnrollmentMailer.student(Enrollment.last).deliver_now
  end

  def author
    EnrollmentMailer.author(Enrollment.last).deliver_now
  end
end
