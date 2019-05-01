class UserMailer < ApplicationMailer



  def password_reset(user)
    @user = user
    mail to: user.email, subject: "Password reset"
  end
  
  def comment
    @greeting = "Hi"

    mail to: "to@example.org"
  end
  
end
