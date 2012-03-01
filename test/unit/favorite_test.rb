require 'test_helper'

class FavoriteTest < ActiveSupport::TestCase

  test "should validate presence of user_id" do
    user =  Favorite.make user: nil
    assert ! user.valid?
    assert user.errors[:user_id]
  end

  test "should validate presence of movie_id" do
    user =  Favorite.make movie: nil
    assert ! user.valid?
    assert user.errors[:movie_id]
  end

  test "should validate presence of rank" do
    user =  Favorite.make rank: nil
    assert ! user.valid?
    assert user.errors[:rank]
  end

  test "should validate rank is a number" do
    user =  Favorite.make rank: "not a number"
    assert ! user.valid?
    assert user.errors[:rank]
  end

  test "should validate rank is => 0" do
    user =  Favorite.make rank: 0
    assert ! user.valid?
    assert user.errors[:rank]
  end

  test "should validate rank is <= 10" do
    user =  Favorite.make rank: 11
    assert ! user.valid?
    assert user.errors[:rank]
  end

  test "should make" do
    assert Favorite.make!
  end
  
  test "should belong to user" do
    assert_nil Favorite.new.user
  end

  test "should belong to movie" do
    assert_nil Favorite.new.movie
  end

end