FactoryBot.define do
  factory :event do
    user # event associate with user
    title { Faker::Lorem.sentence }
    content { Faker::Lorem.paragraph }
    start_date_time { Faker::Time.between(from: DateTime.now + 1, to: DateTime.now + 2)}
    end_date_time { Faker::Time.between(from: DateTime.now + 3, to: DateTime.now + 4)}
    guests { Faker::Number.between(from: 1, to: 10)}
  end
end

# start_date_time (from: DateTime.now + 1, to: DateTme.now + 2) = a day from now to the next day
# end_date_time (from: DateTime.now + 3, to: DateTime.now + 4) = 3 day from now to the next day - this is to make sure end_date_time is after start_date_time
