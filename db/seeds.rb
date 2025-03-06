require 'csv'

puts "Cleaning database..."
IngredientTrait.destroy_all
SandwichIngredient.destroy_all
Trait.destroy_all
Ingredient.destroy_all
Sandwich.destroy_all
User.destroy_all

def ingredients_from_csv(csv_text)
  csv = CSV.parse(csv_text, headers: true, encoding: 'ISO-8859-1')
  csv.each do |row|
    ### Init Ingredient
    ingredient = Ingredient.create!(name: row['name'], description: row['description'],
                                    ingr_type: row['ingr_type'], unit_of_measure: row['unit_of_measure'],
                                    image_url: row['image_url'])

    ### Parse Flavors
    flavor = row['flavor'].split('|')
    flavor.each do |f|
      if Trait.find_by(name: f).nil?
        # puts "Not found"
        trait = Trait.create!(name: f, trait_type: "flavor")
        puts "Created flavor: #{trait.name}"
      else
        # puts "Found"
        trait = Trait.find_by(name: f)
      end
      IngredientTrait.create!(ingredient_id: ingredient.id, trait_id: trait.id)
    end

    ### Parse Textures
    texture = row['texture'].split('|')
    texture.each do |f|
      if Trait.find_by(name: f) == nil
        trait = Trait.create!(name: f, trait_type: "texture")
        puts "Created texture: #{trait.name}"
      else
        trait = Trait.find_by(name: f)
      end
      IngredientTrait.create!(ingredient_id: ingredient.id, trait_id: trait.id)
    end

    ### Parse Origin
    country = row['origin'].split('|')
    country.each do |f|
      if Trait.find_by(name: f) == nil
        trait = Trait.create!(name: f, trait_type: "origin")
        puts "Created origin: #{trait.name}"
      else
        trait = Trait.find_by(name: f)
      end
      IngredientTrait.create!(ingredient_id: ingredient.id, trait_id: trait.id)
    end
  end
end

ingredients_from_csv(File.read('db/Data/breads.csv'))
ingredients_from_csv(File.read('db/Data/cheeses.csv'))
ingredients_from_csv(File.read('db/Data/meats.csv'))
ingredients_from_csv(File.read('db/Data/sauces.csv'))
ingredients_from_csv(File.read('db/Data/vegetables.csv'))

puts "Creating users..."
users = [
  { username: "SandwichKing", email: "sandwichking@example.com", password: "password123"},
  { username: "Ranald_McDougal", email: "ranaldmcdougal@example.com", password: "password123"},
  { username: "THICCWendy", email: "wendythicc@example.com", password: "password123"},
  { username: "Carl_Senior", email: "carlsenior@example.com", password: "password123"}
]

users.each do |user_data|
  user = User.create!(user_data)
  puts "Created user: #{user.username}" # Confirm user creation
end

puts "Creating Sandwiches..."
sandwiches = [
  { user_id: User.first.id, name: "Cheese Burger", description: "placeholder..." },
  { user_id: User.first.id, name: "Double Cheese Burger", description: "placeholder..." },
  { user_id: User.first.id, name: "Bacon Crispy Chicken", description: "placeholder..." },
]

sandwiches.each do |sandwich_data|
  sandwich = Sandwich.create!(sandwich_data)
  puts "Created sandwich: #{sandwich.name}" # Confirm user creation
end

puts "Adding ingredients to sandwiches..."
sandwich_ingr = [
  { sandwich_id: Sandwich.find_by(name: "Cheese Burger").id,
    ingredient_id: Ingredient.find_by(name: "Kaiser Roll").id,
    ingredient_qty: 1, ingredient_position: 4 },
  { sandwich_id: Sandwich.find_by(name: "Cheese Burger").id,
    ingredient_id: Ingredient.find_by(name: "Cheddar").id,
    ingredient_qty: 1, ingredient_position: 3 },
  { sandwich_id: Sandwich.find_by(name: "Cheese Burger").id,
    ingredient_id: Ingredient.find_by(name: "Ground Beef Patty").id,
    ingredient_qty: 1, ingredient_position: 2 },
  { sandwich_id: Sandwich.find_by(name: "Cheese Burger").id,
    ingredient_id: Ingredient.find_by(name: "Kaiser Roll").id,
    ingredient_qty: 1, ingredient_position: 1 },
  ###
  { sandwich_id: Sandwich.find_by(name: "Double Cheese Burger").id,
    ingredient_id: Ingredient.find_by(name: "Kaiser Roll").id,
    ingredient_qty: 1, ingredient_position: 6 },
  { sandwich_id: Sandwich.find_by(name: "Double Cheese Burger").id,
    ingredient_id: Ingredient.find_by(name: "Cheddar").id,
    ingredient_qty: 1, ingredient_position: 5 },
  { sandwich_id: Sandwich.find_by(name: "Double Cheese Burger").id,
    ingredient_id: Ingredient.find_by(name: "Ground Beef Patty").id,
    ingredient_qty: 1, ingredient_position: 4 },
  { sandwich_id: Sandwich.find_by(name: "Double Cheese Burger").id,
    ingredient_id: Ingredient.find_by(name: "Cheddar").id,
    ingredient_qty: 1, ingredient_position: 3 },
  { sandwich_id: Sandwich.find_by(name: "Double Cheese Burger").id,
    ingredient_id: Ingredient.find_by(name: "Ground Beef Patty").id,
    ingredient_qty: 1, ingredient_position: 2 },
  { sandwich_id: Sandwich.find_by(name: "Double Cheese Burger").id,
    ingredient_id: Ingredient.find_by(name: "Kaiser Roll").id,
    ingredient_qty: 1, ingredient_position: 1 },
  ###
  { sandwich_id: Sandwich.find_by(name: "Bacon Crispy Chicken").id,
    ingredient_id: Ingredient.find_by(name: "Pretzel Bun").id,
    ingredient_qty: 1, ingredient_position: 7 },
  { sandwich_id: Sandwich.find_by(name: "Bacon Crispy Chicken").id,
    ingredient_id: Ingredient.find_by(name: "mustard").id,
    ingredient_qty: 1, ingredient_position: 6 },
  { sandwich_id: Sandwich.find_by(name: "Bacon Crispy Chicken").id,
    ingredient_id: Ingredient.find_by(name: "Lettuce").id,
    ingredient_qty: 1, ingredient_position: 5 },
  { sandwich_id: Sandwich.find_by(name: "Bacon Crispy Chicken").id,
    ingredient_id: Ingredient.find_by(name: "White onion").id,
    ingredient_qty: 1, ingredient_position: 4 },
  { sandwich_id: Sandwich.find_by(name: "Bacon Crispy Chicken").id,
    ingredient_id: Ingredient.find_by(name: "Bacon").id,
    ingredient_qty: 1, ingredient_position: 3 },
  { sandwich_id: Sandwich.find_by(name: "Bacon Crispy Chicken").id,
    ingredient_id: Ingredient.find_by(name: "Fried Chicken").id,
    ingredient_qty: 1, ingredient_position: 2 },
  { sandwich_id: Sandwich.find_by(name: "Bacon Crispy Chicken").id,
    ingredient_id: Ingredient.find_by(name: "Pretzel Bun").id,
    ingredient_qty: 1, ingredient_position: 1 }
  ###
]

sandwich_ingr.each do |sandwich_ingr_data|
  sandwich_ingr = SandwichIngredient.create!(sandwich_ingr_data)
  puts "Applied ingredients to sandwich: #{sandwich_ingr.id}" # Confirm user creation
end
