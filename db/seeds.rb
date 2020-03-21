# frozen_string_literal: true

AdminUser.create!(
  email: 'admin@example.com',
  password: '123456789',
  password_confirmation: '123456789'
)

50.times do |i|
  User.create!(
    email: "user#{i}@example.com",
    password: '123456789',
    password_confirmation: '123456789'
  )
end

# image_data = File.read(Rails.root + 'db/seed_images/beef.png')
# t = Ingredient.create!(  name: "Beef",  price: rand(0.01..6.99),  image: Base64.encode64(image_data))

# file:///home/drakedalfa/projects/glasswing/rails2/pizzapp/db/seed_images/beef.png
# file:///home/drakedalfa/projects/glasswing/rails2/pizzapp/db/seed_images/chesse.jpeg
# file:///home/drakedalfa/projects/glasswing/rails2/pizzapp/db/seed_images/pepperoni.png
# file:///home/drakedalfa/projects/glasswing/rails2/pizzapp/db/seed_images/peppers.jpg
# file:///home/drakedalfa/projects/glasswing/rails2/pizzapp/db/seed_images/pineapple.png
# file:///home/drakedalfa/projects/glasswing/rails2/pizzapp/db/seed_images/salame.jpeg
# file:///home/drakedalfa/projects/glasswing/rails2/pizzapp/db/seed_images/tomatoes.jpg
# file:///home/drakedalfa/projects/glasswing/rails2/pizzapp/db/seed_images/tomatoesjpg

%w[Beef Cheesse Pepeperoni Peppers Pineapple Salame Tomatoes].each do |ingredient|
  Ingredient.create(
    name: ingredient,
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
    name: Faker::Food.dish,
    price: rand(2.35..8.99)
  )
end

25.times do
  Branch.create(
    name: Faker::Address.unique.community,
    address: Faker::Address.full_address
  )
end

40.times do
  user = User.pluck(:id).sample
  info = Faker::Food.dish

  Pizza.create(
    user_id: user,
    name: info,
    description: info,
    specialty_id: Specialty.pluck(:id).sample,
    size_id: Size.pluck(:id).sample
  )
end

40.times do
  user = User.pluck(:id).sample
  info = Faker::Food.dish + ' ' + Faker::Food.dish
  ingredients_count = Ingredient.count
  ingredient_ids = Ingredient.pluck(:id)
  ingredients = []

  how_many_ingredients = rand(1..ingredients_count)

  how_many_ingredients.times do
    ingredients.push ingredient_ids.sample
  end

  Pizza.create(
    user_id: user,
    name: info,
    description: info,
    ingredient_ids: ingredients.uniq,
    size_id: Size.pluck(:id).sample
  )
end

250.times do
  how_many_items = rand(1..12)
  user_id = User.pluck(:id).sample
  pizzas = User.find(user_id).pizzas.pluck(:id)
  cart = Cart.create

  if User.find(user_id).pizzas.count == 0
    3.times do
      info = Faker::Food.dish

      Pizza.create(
        user_id: user_id,
        name: info,
        description: info,
        specialty_id: Specialty.pluck(:id).sample,
        size_id: Size.pluck(:id).sample
      )
    end
  end

  how_many_items.times do
    LineItem.create(
      quantity: rand(1..9),
      pizza_id: pizzas.sample,
      cart_id: cart.id
    )
  end

  order = Order.new(user_id: user_id)
  cart.line_items.each do |item|
    order.line_items << item
    item.cart_id = nil
  end
  order.total = order.sub_total
  order.save
end
