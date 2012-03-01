class Movie < ActiveRecord::Base
  validates :title, presence: true
  validates :url, presence: true
  validates :imdb_id, presence: true
  has_many :favorites
  attr_reader :year, :director, :genres, :cast_members, :poster, :trailer_url
  attr_accessor :imdb
  def self.top
    Movie.order("points desc")
  end

  def self.ten
    self.limit(10)
  end

  # def imdb
  #   Imdb::Movie.new(imdb_id)
  # end
  # extend ActiveSupport::Memoizable
  # memoize :imdb

  # scope :top, order("points desc")
  # scope :ten, limit(10)
end