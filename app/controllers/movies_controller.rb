# frozen_string_literal: true

class MoviesController < ApplicationController
  def index
    render json: Movie.page(params[:page])
  end

  def recommendations
    favorite_movies = User.find(params[:user_id]).favorites
    @recommendations = RecommendationsService.call(favorite_movies)
    render json: @recommendations
  end

  def rent
    movie = RentService.call(params)

    render json: movie
  rescue RentService::MovieNotAvailable
    # TODO: better error handling
    render json: { error: 'movie is not available' }, status: :bad_request
  end
end
