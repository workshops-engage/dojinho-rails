require 'test_helper'

class UserTest < ActiveSupport::TestCase

  test "should validate presence of name" do
    user = User.make name: nil
    assert ! user.valid?
    assert user.errors[:name]
  end

  test "should have many favorites" do
    assert_equal [], User.new.favorites
  end

  test "should make" do
    assert User.make!
  end

end