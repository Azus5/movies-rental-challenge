require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  class RentedMoviesTest < UsersControllerTest
    setup do
      @user = create(:user, :with_rented_movies, rented_movies_amount: 3)
    end

    test 'should redirect request to new url' do
      get "#{movies_user_rented_movies_path}?user_id=#{@user.id}", as: :json # old path /movies/user_rented_movies?user_id=<user_id>

      assert_response :moved_permanently
      assert_redirected_to "#{rented_movies_path}?user_id=#{@user.id}" # new path /users/rented_movies?user_id=<user_id>
    end

    test 'should return rentals' do
      get "#{rented_movies_path}?user_id=#{@user.id}", as: :json

      assert_response :success
      assert_equal 3, @response.parsed_body.count
    end
  end
end
