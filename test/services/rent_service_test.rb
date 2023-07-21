require 'test_helper'

class RentServiceTest < ActiveSupport::TestCase
  setup do
    @user = create(:user)
  end

  test 'should fail if user_id or movie_id is invalid' do
    assert_raises(ActiveRecord::RecordNotFound) do
      RentService.call({ user_id: 999, id: 999 })
    end
  end

  test 'should fail if movie is sold out' do
    movie = create(:movie, available_copies: 0)

    assert_raises(RentService::MovieNotAvailable) do
      RentService.call({ user_id: @user.id, id: movie.id })
    end
  end

  test 'should update records correctly' do
    movie = create(:movie, available_copies: 1)

    assert_changes -> { [movie.reload.available_copies, @user.reload.rentals.count] }, from: [1, 0], to: [0, 1] do
      RentService.call({ user_id: @user.id, id: movie.id })
    end
  end
end
