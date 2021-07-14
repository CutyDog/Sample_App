require 'test_helper'
require 'cgi'

class MicropostsInterfaceTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:michael)
    @second_user = users(:archer)
    @third_user = users(:lana)
  end
  
  test "micropost interface" do
    log_in_as(@user)
    get root_path
    assert_select 'div.pagination'
    assert_select 'input[type=file]'
    # 無効な送信
    assert_no_difference 'Micropost.count' do
      post microposts_path, params: { micropost: { content: "" } }
    end  
    assert_select 'div#error_explanation'
    # 有効な送信
    picture = fixture_file_upload('test/fixtures/rails.png', 'image/png')
    assert_difference 'Micropost.count', 1 do
      post  microposts_path, params: { micropost: { content: "content", 
                                                    picture: picture } }
    end  
    assert_not flash.empty?
    assert_redirected_to root_url
    follow_redirect!
    assert_match "content", response.body
    # 投稿を削除する
    assert_select 'a', text: 'delete'
    first_micropost = @user.microposts.paginate(page: 1).first
    assert_difference 'Micropost.count', -1 do
      delete micropost_path(first_micropost)
    end  
    assert_not flash.empty?
    assert_redirected_to request.referrer || root_url
    # 違うユーザーのプロフィールにアクセス (削除リンクがないことを確認)
    get user_path(users(:archer))
    assert_select 'a', text: 'delete', count: 0
  end  
  
  test "micropost sidebar count" do
    log_in_as(@user)
    get root_path
    assert_match "#{@user.microposts.count} microposts", response.body
    # まだマイクロポストを投稿していないユーザー
    other_user = users(:malory)
    log_in_as(other_user)
    get root_path
    assert_match "0 microposts", response.body
    other_user.microposts.create!(content: "A micropost")
    get root_path
    assert_match "1 micropost", response.body
  end  
  
  test "reply interface" do
    log_in_as(@user)
    content = "@Lana Kane, This is Reply Message."
    post  microposts_path, params: { micropost: { content: content }}
    follow_redirect!
    assert_match "@Lana Kane,", response.body
    
    log_out(@user)
    log_in_as(@second_user)
    get root_path
    assert_equal @second_user.feed.where(user_id: @user).count, @user.microposts.count-1
    
    log_out(@second_user)
    log_in_as(@third_user)
    follow_redirect!
    @user.microposts.each do |post_following|
      assert @third_user.feed.include?(post_following)
    end
  end  
end
