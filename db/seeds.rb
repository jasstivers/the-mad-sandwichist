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
    ingredient = Ingredient.create!(name: row['name'].downcase, description: row['description'],
                                    ingr_type: row['ingr_type'], unit_of_measure: row['unit_of_measure'],
                                    image_url: row['image_url'])
    puts "Creating #{ingredient.name}"

    ### Parse Flavors
    flavor = row['flavor'].split('|')
    flavor.each do |f|
      if Trait.find_by(name: f.downcase).nil?
        # puts "Not found"
        trait = Trait.create!(name: f.downcase, trait_type: "flavor")
        # puts "Created flavor: #{trait.name}"
      else
        # puts "Found"
        trait = Trait.find_by(name: f.downcase)
      end
      IngredientTrait.create!(ingredient_id: ingredient.id, trait_id: trait.id)
    end

    ### Parse Textures
    texture = row['texture'].split('|')
    texture.each do |f|
      if Trait.find_by(name: f.downcase).nil?
        trait = Trait.create!(name: f.downcase, trait_type: "texture")
        # puts "Created texture: #{trait.name}"
      else
        trait = Trait.find_by(name: f.downcase)
      end
      IngredientTrait.create!(ingredient_id: ingredient.id, trait_id: trait.id)
    end

    ### Parse Origin
    country = row['origin'].split('|')
    country.each do |f|
      if Trait.find_by(name: f.downcase).nil?
        trait = Trait.create!(name: f.downcase, trait_type: "origin")
        # puts "Created origin: #{trait.name}"
      else
        trait = Trait.find_by(name: f.downcase)
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
  { username: "Carl_Senior", email: "carlsenior@example.com", password: "password123"},
  { username: "Ma Creedly", email:"creedly@example.com", password: "password123"}
]

users.each do |user_data|
  user = User.create!(user_data)
  puts "Created user: #{user.username}" # Confirm user creation
end

def sandwiches_from_csv(csv_text)
  csv = CSV.parse(csv_text, headers: true, encoding: 'ISO-8859-1')
  csv.each do |row|
    ### Init Sandwiches ###
    sandwich = Sandwich.create!(user_id: User.find_by(username: row['username']).id, name: row['name'], description: row['description'])

    ### Parse Ingredients ###
    sandwich_ingredients = row['ingredients'].split('|')
    sandwich_size = 1
    sandwich_ingredients.each do |f|
      SandwichIngredient.create!(sandwich_id: sandwich.id, ingredient_id: Ingredient.find_by(name: f.downcase).id,
                                 ingredient_qty: 1, ingredient_position: sandwich_size)
      sandwich_size += 1
    end
    puts "Created sandwich: #{sandwich.name}"
  end
end

sandwiches_from_csv(File.read('db/Data/sandwiches.csv'))
