require "test_helper"

class TweetStreamsControllerTest < ActionController::TestCase

  test "stubs the current user" do
    user = User.create!(name: 'Brett Grigsby', 
			nickname: 'brettgrigsby', 
			image: 'https://avatars.githubusercontent.com/u/8657755?v=3', 
			uid: '8657755', 
			provider: 'github', 
			token: '9d134844a8af449f9fb61b721991b37bd78397fa')
    @controller.expects(:current_user).returns(user)

    post :show
    assert_response :success
    assert_not_nil assigns(:tweets)
    assert_select "li.tweet"
  end
end

