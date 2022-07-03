require "test_helper"

class RelationshipsControllerTest < ActionDispatch::IntegrationTest
  test "should get follower_to_followeds" do
    get relationships_follower_to_followeds_url
    assert_response :success
  end

  test "should get followed_to_followers" do
    get relationships_followed_to_followers_url
    assert_response :success
  end
end
