# Use this hook to configure merit parameters
Merit.setup do |config|
  # Check rules on each request or in background
  # config.checks_on_each_request = true

  # Add application observers to get notifications when reputation changes.
  # config.add_observer 'MyObserverClassName'

  # Define :user_model_name. This model will be used to grant badge if no
  # `:to` option is given. Default is 'User'.
  # config.user_model_name = 'User'

  # Define :current_user_method. Similar to previous option. It will be used
  # to retrieve :user_model_name object if no `:to` option is given. Default
  # is "current_#{user_model_name.downcase}".
  # config.current_user_method = 'current_user'
end

# Create application badges (uses https://github.com/norman/ambry)
# Rails.application.reloader.to_prepare do
#   badge_id = 0
#   [{
#     id: (badge_id = badge_id+1),
#     name: 'just-registered'
#   }, {
#     id: (badge_id = badge_id+1),
#     name: 'best-unicorn',
#     custom_fields: { category: 'fantasy' }
#   }].each do |attrs|
#     Merit::Badge.create! attrs
#   end
# end

Rails.application.reloader.to_prepare do
  Merit::Badge.create!(
    id: 1,
    name: "The Journey Begins",
    description: "Created your first sandwich!",
  )

  Merit::Badge.create!(
    id: 2,
    name: "Earl of Sandwich",
    description: "Created 5 sandwiches!",
  )

  Merit::Badge.create!(
    id: 3,
    name: "Tastemaker",
    description: "Have a sandwich reach 4 stars with 50 reviews!",
  )

  Merit::Badge.create!(
    id: 4,
    name: "B.L.Team!",
    description: "Created a sandwich with bacon, lettuce, and tomato!",
  )

  Merit::Badge.create!(
    id: 5,
    name: "Bun to be Wild",
    description: "Created a sandwich with a only bread!",
  )

  Merit::Badge.create!(
    id: 6,
    name: "Spread the Love",
    description: "Created a sandwich with 5 or more condiments!",
  )

  Merit::Badge.create!(
    id: 7,
    name: "What hath God Wrought",
    description: "Created a sandwich with over 10 listed flavors!",
  )
end
