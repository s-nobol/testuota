class UserMailer < ApplicationMailer



  def password_reset(user)
    @user = user
    mail to: user.email, subject: "Password reset"
  end
  
  def comment(comment)
    @comment = comment
    @post = Post.find(@comment.post_id)
    @greeting = "Hi"

    mail to: "to@example.org"
  end
  
end
