require 'test_helper'

class CommentTest < ActiveSupport::TestCase

  def setup
    @one = comments :buy_first
  end

  test "properties" do
    assert @one.goal
    assert @one.user
    assert @one.comment
    assert @one.date
  end

end
