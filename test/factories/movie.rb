FactoryBot.define do
  factory :movie do
    sequence(:title) { |n| "The Shawshank Redemption #{n}" }
    genre { 'Drama' }
    rating { 1.76 }
    available_copies { 6 }
  end
end
