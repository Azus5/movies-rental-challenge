require 'test_helper'

class MoviesControllerTest < ActionDispatch::IntegrationTest
  class IndexTest < MoviesControllerTest
    setup do
      create_list(:movie, 25)
    end

    test 'should get index paginated' do
      get movies_url, as: :json

      assert_response :success
      assert_equal 15, @response.parsed_body.count
    end

    test 'should be return correct page' do
      get "#{movies_url}?page=2", as: :json

      assert_response :success
      assert_equal 10, @response.parsed_body.count
      assert_equal 16, @response.parsed_body.first['id']
    end
  end

  class RentTest < MoviesControllerTest
    setup do
      @user = create(:user)
    end

    test 'should rent movie' do
      movie = create(:movie, available_copies: 1)
      assert_changes -> { [movie.reload.available_copies, @user.reload.rentals.count] }, from: [1, 0], to: [0, 1] do
        get rent_movie_path(movie.id, { user_id: @user.id })
      end

      assert_response :success
    end

    test 'should return error if movie is sold out' do
      movie = create(:movie, available_copies: 0)
      assert_no_changes -> { [movie.reload.available_copies, @user.reload.rentals.count] } do
        get rent_movie_path(movie.id, { user_id: @user.id })
      end

      assert_response :bad_request
      assert_equal 'movie is not available', @response.parsed_body['error']
    end
  end
end
