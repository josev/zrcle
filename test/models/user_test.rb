require 'test_helper'

class UserTest < ActiveSupport::TestCase

  def setup
    @john = users :john
    @pete = users :pete
  end

  test "email is unique" do
    @john.email = @pete.email
    assert_not @john.save
  end

  test "register" do
    user_hash = { name: "Doo", lastname: "Foo", email: "new@user.com"  }
    new_user = User.create user_hash
    assert_instance_of User, new_user
  end

  test "has many goals" do
    pete_count = 2
    assert_equal UserGoal.where( user: @pete ).count, pete_count
    assert_equal @pete.goals.count, pete_count

  end

  test "finding by email" do
    found = User.find_by_email @john.email
    assert_equal found, @john
  end

end
