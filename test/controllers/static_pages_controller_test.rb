require 'test_helper'

class StaticPagesControllerTest < ActionDispatch::IntegrationTest
  test "should get home" do
    get static_pages_home_url
    assert_response :success
  end


  # とりあえず削除
  # test "should get about" do
  #   get static_pages_about_url
  #   assert_response :success
  # end

  # test "should get help" do
  #   get static_pages_help_url
  #   assert_response :success
  # end

  # test "should get agreement" do
  #   get static_pages_agreement_url
  #   assert_response :success
  # end

  # test "should get policy" do
  #   get static_pages_policy_url
  #   assert_response :success
  # end

  # test "should get corporate" do
  #   get static_pages_corporate_url
  #   assert_response :success
  # end

end
