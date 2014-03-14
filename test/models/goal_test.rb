require 'test_helper'

class GoalTest < ActiveSupport::TestCase

  def setup
    @to_buy = goals :buy
    @to_lose = goals :lose
    @user = users :pete
    @cat = goal_categories :sports
    @type = goal_types :progressive
  end

  test "creating a goal" do
    goal_params = { user_id: @user.id, name: "Climb mountain", description: "Go higher each day.", image: "image.url", goal_category_id: @cat.id, goal_type_id: @type.id }
    assert Goal.create( goal_params )
  end

  test "followers" do
    assert_equal @to_buy.followers.count, 2
  end

  test "comments" do
    assert @to_buy.comments
  end

  test "info" do
    assert @to_buy.description
    assert @to_buy.expected_result
    assert @to_buy.rate
  end

  test "progress" do
    @follower = @to_buy.followers.first
    assert @to_buy.progress( @follower )
  end

end
