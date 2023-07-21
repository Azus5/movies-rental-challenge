class RentService < ApplicationService
  class MovieNotAvailable < StandardError; end

  def initialize(params)
    @user_id = params[:user_id]
    @movie_id = params[:id]
  end

  def call
    raise MovieNotAvailable, 'movie is not available' if movie.not_available?

    movie.sell_copy!

    user.rented << movie

    movie
  end

  private

  def user
    @user ||= User.find(@user_id)
  end

  def movie
    @movie ||= Movie.find(@movie_id)
  end
end
