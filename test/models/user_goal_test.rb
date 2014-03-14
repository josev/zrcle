require 'test_helper'

class UserGoalTest < ActiveSupport::TestCase

  def setup
    @goal = user_goals(:buy_one)
  end

  test "status" do
    assert @goal.state
  end



end
