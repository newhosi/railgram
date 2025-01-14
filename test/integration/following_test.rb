require "test_helper"

class FollowingTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:test_user)
    @other = users(:test_user_2)
    log_in_as(@user)
  end

  test "following page" do
    get following_user_path(@user)
    assert_not @user.following.empty?
    assert_match @user.following.count.to_s, response.body
    @user.following.each do |user|
      assert_select "a[href=?]", user_path(user)
    end
  end

  test "followers page" do
    get followers_user_path(@user)
    assert_not @user.followers.empty?
    assert_match @user.followers.count.to_s, response.body
    @user.followers.each do |user|
      assert_select "a[href=?]", user_path(user)
    end
  end

  test "should follow a user the standard way" do
    assert_difference "@user.following.count", 1 do
      post relationships_path, params: { followed_id: @other.id }
    end
  end

  test "shold follow a user with turbo" do
    post relationships_path, params: { followed_id: @other.id }, as: :turbo_stream
    assert_turbo_stream action: :replace, target: "follow_button" do |selected|
      assert_match "Unfollow", selected.children.to_html
    end
  end

  test "should unfollow a user the standard way" do
    @user.follow(@other)
    relationship = @user.active_relationships.find_by(followed_id: @other.id)
    assert_difference "@user.following.count", -1 do
      delete relationship_path(relationship)
    end
  end

  test "shold unfollow a user with turbo" do
    @user.follow(@other)
    relationship = @user.active_relationships.find_by(followed_id: @other.id)
    delete relationship_path(relationship), as: :turbo_stream
    assert_turbo_stream action: :replace, target: "follow_button" do |selected|
      assert_match "follow", selected.children.to_html
    end
  end
end
