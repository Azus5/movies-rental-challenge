FactoryBot.define do
  factory :user do
    sequence(:name) { |n| "John #{n}" }

    trait :with_rented_movies do
      transient do
        rented_movies_amount { 2 }
      end

      rentals { create_list(:rental, rented_movies_amount) }
    end
  end
end
