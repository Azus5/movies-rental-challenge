# frozen_string_literal: true

class UsersController < ApplicationController
  def rented_movies
    @rented = User.find(params[:user_id]).rented
    render json: @rented
  end
end
