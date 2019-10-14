require 'test_helper'

class UserControllerTest < ActionDispatch::IntegrationTest
  test "should post login" do
    post '/users/login', params: {email: "cloudinfra@example.com", password: "test"}
    assert_response :success
  end

  test "should post create" do
    post '/users', params: {email: "test_create@example.com", password: "test", name: "newly_create"}
    assert_response :success
  end

end
