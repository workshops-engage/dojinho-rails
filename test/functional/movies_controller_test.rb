# encoding: UTF-8

require 'ostruct'
require 'test_helper'

class MoviesControllerTest < ActionController::TestCase
  
  setup do
    @movie = Movie.make! title: "Loucademia de Polícia"
    Movie.any_instance.stubs(:imdb).returns(OpenStruct.new({
      poster: "http://poster.com/foo.jpg",
      trailer_url: "http://trailer.com/trailer.html",
      director: ['Hugh Wilson', 'Someone Else'],
      year: 1984,
      cast_members: ['Steve Guttenberg', 'Michael Winslow'],
      genres: ['Comedy']
    }))
    5.times{ Favorite.make! movie: @movie }
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_select "h1", "Movies"
    assert_select "ul#movies" do
      assert_select "li", 1
      assert_select "li" do
        assert_select "a", @movie.title do
          assert_select "a[href=?]", movie_path(@movie)
        end
      end
    end
  end
  
  test "should get show" do
    get :show, id: @movie
    assert_response :success
    assert_select "h1", "Loucademia de Polícia"
    assert_select "ul#users" do
      assert_select "li", 5
      @movie.favorites.each do |favorite|
        assert_select "li[data-rank=#{favorite.rank}]" do
          assert_select "span.rank", favorite.rank.to_s
          assert_select "a[href=?]", user_path(favorite.user)
          assert_select "a", favorite.user.name
        end
      end
    end
    #puts response.body
    assert_select "img#poster[src=?]", "http://poster.com/foo.jpg"

    assert_select "a#trailer", "Trailer" do
      assert_select "[href=?]", "http://trailer.com/trailer.html"
    end
    
    assert_select "div#director", "Hugh Wilson and Someone Else"

    assert_select "div#year", "1984"

    assert_select "ul#cast-members" do
      assert_select 'li', 2
      assert_select 'li', 'Steve Guttenberg'
      assert_select 'li', 'Michael Winslow'
    end

     assert_select "ul#genres" do
       assert_select 'li', 1
       assert_select 'li', 'Comedy'
     end

   end

end