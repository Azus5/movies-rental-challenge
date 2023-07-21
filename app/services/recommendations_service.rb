class RecommendationsService < ApplicationService
  def initialize(favorite_movies)
    @favorite_movies = favorite_movies
  end

  def call
    movie_titles = get_movie_names(@favorite_movies)
    genres = Movie.where(title: movie_titles).pluck(:genre)
    common_genres = genres.group_by { |e| e }.sort_by { |_k, v| -v.length }.map(&:first).take(3)
    Movie.where(genre: common_genres).order(rating: :desc).limit(10)
  end

  private

  def get_movie_names(_movies)
    names = []
    @favorite_movies.each do |movie|
      names << movie.title
    end

    names
  end
end
