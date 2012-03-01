require 'test_helper'

class HomeControllerTest < ActionController::TestCase

  test "should get index - not signed in" do
    get :index
    assert_response :success

    assert_select 'div#sign_in' do
      assert_select 'a', 'Sign in' do
        assert_select '[href=?]', new_user_session_path
      end
    end

    assert_select 'div#welcome', 0
    assert_select 'div#sign_out', 0
  end

  test "should get index - signed in" do
    user = User.make! name: 'Maguila'
    top = Favorite.make! user: user, rank: 1
    15.times{ Favorite.make! rank: 10 }
    sign_in user
    get :index
    assert_response :success
    assert_select 'a', 'Add favorite' do
      assert_select '[href=?]', new_favorite_path
    end

    assert_select 'div#welcome', "Welcome, Maguila"

    assert_select 'div#sign_out' do
      assert_select 'a', 'Sign out' do
        assert_select '[href=?]', destroy_user_session_path
        assert_select '[data-method=?]', "delete"
      end
    end

    assert_select 'div#sign_in', 0

    assert_select 'div#menu' do
      assert_select 'a', 'Home' do
        assert_select '[href=?]', root_path
      end
      assert_select 'a', 'Movies' do
        assert_select '[href=?]', movies_path
      end
      assert_select 'a', 'Users' do
        assert_select '[href=?]', users_path
      end
    end

    assert_select 'ol#top' do
      assert_select 'li', 10
    end
    assert_select 'ol#top li:first-child a', top.movie.title
  end

end