require 'test_helper'

class UserSignupTest < ActionDispatch::IntegrationTest

  test "invalid signup information" do
    get signup_path
    assert_no_difference 'User.count' do
      post users_path, params: { user: { name:  "",
                                         email: "user@invalid",
                                         password:              "foo",
                                         password_confirmation: "bar" } }
    end
    #Check after an invalid sign up attempt that the new action from the users 
    #controller will be rendered 
    assert_template 'users/new'
    #and that it will contain a HTML div with the class 'field with errors'
    assert_select 'div.field_with_errors'
    #and one with the ID of 'error_explanation'
    assert_select 'div#error_explanation'

    assert_select 'form[action="/signup"]'
  end

  test "valid signup information" do
    get signup_path
    assert_difference 'User.count', 1 do
      post users_path, params: { user: { name:  "Example User",
                                         email: "user@example.com",
                                         password:              "password",
                                         password_confirmation: "password" } }
    end
    follow_redirect!
    assert_template 'users/show'
    assert_not flash.nil?
    assert is_logged_in?
  end
end
