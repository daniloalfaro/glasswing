# frozen_string_literal: true

AdminUser.create!(
  email: 'admin@example.com',
  password: '123456789',
  password_confirmation: '123456789'
)

User.create!(
  email: 'user@example.com',
  password: '123456789',
  password_confirmation: '123456789'
)

25.times do
  Ingredient.create(
    name: Faker::Food.unique.ingredient,
    price: rand(0.01..6.99)
  )
end

%w[Personal Normal Familiar].each do |size|
  Size.create!(
    name: size,
    price: rand(0.50..14.99)
  )
end

10.times do
  Specialty.create(
    name: Faker::Food.unique.dish,
    price: rand(2.35..8.99)
  )
end

25.times do
  Branch.create(
    name: Faker::Address.unique.community,
    address: Faker::Address.full_address
  )
end
