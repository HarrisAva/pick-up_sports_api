(1..10).each do |i|
    user = User.create(
        username: Faker::Internet.username,
        email: Faker::Internet.email,
        first_name: Faker::Name.first_name,
        last_name: Faker::Name.last_name,
        password: 'password',
        password_confirmation: 'password'
    )

    rand(1..10).times do
        user.posts.create(content: Faker::Lorem.paragraph)
    end
end
