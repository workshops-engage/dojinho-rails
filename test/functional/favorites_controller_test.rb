require 'test_helper'

class FavoritesControllerTest < ActionController::TestCase

  setup do
    @user = User.make!
  end
  
  test "should not get index - not signed in" do
    get :index
    assert_response :redirect
    assert_redirected_to new_user_session_path
  end
  
  test "should not get new - not signed in" do
    get :new
    assert_response :redirect
    assert_redirected_to new_user_session_path
  end
  
  test "should not post create - not signed in" do
    post :create
    assert_response :redirect
    assert_redirected_to new_user_session_path
  end
  
  test "should get index" do
    sign_in @user
    movie = Movie.make! title: 'Revenge of the Nerds'
    Favorite.make! rank: 1, movie: movie, user: @user
    get :index
    assert_response :success
    assert_select 'a', 'Add favorite' do
      assert_select '[href=?]', new_favorite_path
    end
    assert_select 'ul#favorites' do
      assert_select 'li[data-rank="1"]' do
        assert_select 'span.rank', '1'
        assert_select 'a', 'Revenge of the Nerds'
      end
    end
  end

  test "should get new" do
    sign_in @user
    get :new
    assert_response :success
    assert_select "form" do
      assert_select "[action=?]", favorites_path
      assert_select "label", "Movie"
      assert_select "select[name=?]", "favorite[movie_id]"
      assert_select "label", "Rank"
      assert_select "select[name=?]", "favorite[rank]"
      assert_select 'input[type="submit"]'
    end
  end

  test "should post create" do
    sign_in @user
    movie = Movie.make!
    post :create, favorite: {movie_id: movie.id, rank: 7}
    assert_response :redirect
    assert_redirected_to favorites_path
  end

end