require 'test_helper'

class MessageTest < ActionDispatch::IntegrationTest
  
  def setup
    @user = users(:michael)
    @second_user = users(:archer)
  end
  
  test "message interface" do
    log_in_as(@user)
    get root_url
    assert_select "a[href=?]", '#talks-tab', count: 1
  end
  
end  