require 'test_helper'

class UserMailerTest < ActionMailer::TestCase
  
  def setup
    @user = User.first
  end
  
  # test "comment" do
    # mail = UserMailer.comment
    # assert_equal "Comment", mail.subject
    # assert_equal ["to@example.org"], mail.to
    # assert_equal ["from@example.com"], mail.from
    # assert_match "Hi", mail.body.encoded
  # end

  # test "password_reset" do
    # @user.reset_token = create_token
    # mail = UserMailer.password_reset(@user)
    # assert_equal "Password reset", mail.subject
    # assert_equal ["to@example.org"], mail.to
    # assert_equal ["from@example.com"], mail.from
    # assert_match "Hi", mail.body.encoded
  # end
  
  # 後日正しく修正

end
