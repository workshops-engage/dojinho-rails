require 'test_helper'

class MovieTest < ActiveSupport::TestCase
  
  test "should validate presence of title" do
    movie = Movie.make title: nil
    assert ! movie.valid?
    assert movie.errors[:title]
  end
  
  test "should validate presence of url" do
    movie = Movie.make url: nil
    assert ! movie.valid?
    assert movie.errors[:url]
  end
  
  test "should validate presence of imdb_id" do
    movie = Movie.make imdb_id: nil
    assert ! movie.valid?
    assert movie.errors[:imdb_id]
  end
  
  test "should have many favorites" do
    assert_equal [], Movie.new.favorites
  end
  
  test "should make" do
    assert Movie.make!
  end
  
  test "should start with 0 points" do
    assert Movie.new.points.zero?
  end
  
  1.upto(10) do |rank|
    test "should add 2^#{10-rank} points when ranked #{rank}" do
      movie = Movie.make!
      assert_difference "movie.points", 2**(10-rank) do
        Favorite.make! movie: movie, rank: rank
      end
    end
  end

  test "should accumulate points" do
    movie = Movie.make!
    assert_difference "movie.points", 7 do
      Favorite.make! movie: movie, rank: 10
      Favorite.make! movie: movie, rank: 9
      Favorite.make! movie: movie, rank: 8
    end
  end
  
  test "should have top scope" do
    assert_equal [], Movie.top
  end

  test "should have ten scope" do
    assert_equal [], Movie.ten
  end

  %w[imdb year director genres cast_members poster trailer_url].each do |meth|
    test "should respond to #{meth}" do
      assert Movie.new.respond_to? meth
    end
  end

end