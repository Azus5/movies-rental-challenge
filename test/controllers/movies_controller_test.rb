require 'test_helper'

class MoviesControllerTest < ActionDispatch::IntegrationTest
  class IndexTest < MoviesControllerTest
    setup do
      create_list(:movie, 24)
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
end
