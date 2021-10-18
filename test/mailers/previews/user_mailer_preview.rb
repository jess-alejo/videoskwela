# Preview all emails at http://localhost:3000/rails/mailers/user_mailer
class UserMailerPreview < ActionMailer::Preview
  def new_user
    user = User.last
    UserMailer.new_user(user).deliver_now
  end
end
