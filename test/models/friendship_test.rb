require 'test_helper'

class FriendshipTest < ActiveSupport::TestCase

  def setup
    @pete = users :pete
    @ron = users :ron
  end

  test "a friend" do
    assert @pete.friends.find @ron
  end

  test "counting friends" do
    assert @pete.friends.count, 2
  end

  test "an inverse friendship" do
    assert @ron.inverse_friends.find @pete
  end

  test "a friend reversed" do
    assert @ron.friends.find @pete
  end
end
