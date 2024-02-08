FactoryBot.define do
  factory :post do
    content { Faker::Lorem.paragraph}
    user 
    # a post associates with a user who create it (mandatory), from users factory
  end
end
