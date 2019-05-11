require 'test_helper'

class MessagesControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    @user = users(:first_user)
    log_in_as(@user)
    get message_path(@user)
  end

end
