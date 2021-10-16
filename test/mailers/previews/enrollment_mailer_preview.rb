# Preview all emails at http://localhost:3000/rails/mailers/enrollment_mailer
class EnrollmentMailerPreview < ActionMailer::Preview
  def new_enrollment
    EnrollmentMailer.new_enrollment(Enrollment.last).deliver_now
  end
end
