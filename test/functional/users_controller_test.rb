require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  
  setup do
    @user = User.make!
    1.upto(10){|rank| Favorite.make! user: @user, rank: rank }
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_select "h1", "Users"
    assert_select "ul#users" do
      assert_select "li", 1
      assert_select "li" do
        assert_select "a", @user.name do
          assert_select "a[href=?]", user_path(@user)
        end
      end
    end
  end

  test "should get show" do
    get :show, id: @user
    assert_response :success
    assert_select "h1", @user.name
    assert_select "ol#movies" do
      assert_select "li", 10
      @user.favorites.each do |favorite|
        assert_select "li[data-rank=#{favorite.rank}]" do
          assert_select "a", favorite.movie.title do
            assert_select "a[href=?]", movie_path(favorite.movie)
          end
        end
      end
    end
  end

end