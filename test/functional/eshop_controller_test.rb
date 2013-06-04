require 'test_helper'

class EshopControllerTest < ActionController::TestCase
  test "should get careers" do
    get :careers
    assert_response :success
  end

  test "should get about" do
    get :about
    assert_response :success
  end

  test "should get help" do
    get :help
    assert_response :success
  end

  test "should get contact" do
    get :contact
    assert_response :success
  end

end
