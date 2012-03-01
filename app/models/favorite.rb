class Favorite < ActiveRecord::Base

  belongs_to :user
  belongs_to :movie
  validates :user, presence: true
  validates :movie, presence: true
  validates :rank, presence: true, numericality: true, inclusion: {in: (1..10)}

  before_create do
    self.movie.points += 2**(10-self.rank)
    self.movie.save
  end

end