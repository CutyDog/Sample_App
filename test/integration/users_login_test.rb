require 'test_helper'

class UsersLoginTest < ActionDispatch::IntegrationTest
  test "login with invalid information" do
    get login_path
    assert_template 'sessions/new'
    
    post login_path, params: { session: {email: "user@invalid", password: "foo"}}
    assert_select "form[action=?]", login_path
    assert_template 'sessions/new'
    assert_not flash.empty? 
    
    get root_path
    assert flash.empty?
  end
end
