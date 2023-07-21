class Movie < ApplicationRecord
  has_many :favorite_movies
  has_many :users, through: :favorite_movies

  validates :available_copies, numericality: { greater_than_or_equal_to: 0 }

  include Paginable

  def sell_copy!
    update!(available_copies: available_copies - 1)
  end

  def not_available?
    !available?
  end

  def available?
    available_copies.positive?
  end
end
