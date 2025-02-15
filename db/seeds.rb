# Ingredient.create([
#   { name: 'Lettuce' },
#   { name: 'Tomato' },
#   { name: 'Cheese' },
#   { name: 'Bacon' },
#   { name: 'Chicken' },
#   { name: 'Avocado' },
#   { name: 'Pickles' }
# ])

require 'faker'

User.destroy_all
Sandwich.destroy_all


user = User.create!(
  email: "test@example.com",
  password: "password",
  password_confirmation: "password"
)


rand(10..15).times do
  Sandwich.create!(
    user: user,
    name: Faker::Food.dish,
    description: Faker::Food.description,
    image_url: "https://source.unsplash.com/400x300/?sandwich"
  )
end

puts "Created #{Sandwich.count} sandwiches!"
