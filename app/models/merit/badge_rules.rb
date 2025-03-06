# Be sure to restart your server when you modify this file.
#
# +grant_on+ accepts:
# * Nothing (always grants)
# * A block which evaluates to boolean (recieves the object as parameter)
# * A block with a hash composed of methods to run on the target object with
#   expected values (+votes: 5+ for instance).
#
# +grant_on+ can have a +:to+ method name, which called over the target object
# should retrieve the object to badge (could be +:user+, +:self+, +:follower+,
# etc). If it's not defined merit will apply the badge to the user who
# triggered the action (:action_user by default). If it's :itself, it badges
# the created object (new user for instance).
#
# The :temporary option indicates that if the condition doesn't hold but the
# badge is granted, then it's removed. It's false by default (badges are kept
# forever).

module Merit
  class BadgeRules
    include Merit::BadgeRulesMethods

    def initialize
      # If it creates user, grant badge
      # Should be "current_user" after registration for badge to be granted.
      # Find badge by badge_id, badge_id takes presidence over badge
      # grant_on 'users#create', badge_id: 7, badge: 'just-registered', to: :itself

      # If it has 10 comments, grant commenter-10 badge
      # grant_on 'comments#create', badge: 'commenter', level: 10 do |comment|
      #   comment.user.comments.count == 10
      # end

      # If it has 5 votes, grant relevant-commenter badge
      # grant_on 'comments#vote', badge: 'relevant-commenter',
      #   to: :user do |comment|
      #
      #   comment.votes.count == 5
      # end

      # Changes his name by one wider than 4 chars (arbitrary ruby code case)
      # grant_on 'registrations#update', badge: 'autobiographer',
      #   temporary: true, model_name: 'User' do |user|
      #
      #   user.name.length > 4
      # end

      grant_on 'sandwiches#create', badge_id: 1, to: :user do |sandwich|
        sandwich.user.sandwiches.count >= 1
      end

      grant_on 'sandwiches#create', badge_id: 2, to: :user do |sandwich|
        sandwich.user.sandwiches.count >= 5
      end
# This needs reviews before it will work
      # grant_on 'reviews#create', badge_id: 3, to: :user do |review|
      #   sandwich = review.sandwich
      #   sandwich.reviews.count >= 50 && sandwich.reviews.average(:rating) >= 4
      # end
# These won't work unless we add ingredients to the sandwich model with a migration
      # grant_on 'sandwiches#create', badge_id: 4, to: :user do |sandwich|
      #   ingredients = sandwich.ingredients.map(&:downcase)
      #   %w[bacon lettuce tomato].all? { |ingredient| ingredients.include?(ingredient) }
      # end

      # grant_on 'sandwich#create', badge_id: 5, to: :user do |sandwich|
      #   ingredients = sandwich.ingredients.map(&:downcase)
      #   ingredients.all? { |ingredient| ingredient.include?('bread') }
      # end

# Place holder trophy earn methods
      # grant_on 'sandwiches#create', badge_id: 4, to: :user do |sandwich|
      #   sandwich.user.sandwiches.count >= 2
      # end

      # grant_on 'sandwiches#create', badge_id: 5, to: :user do |sandwich|
      #   sandwich.user.sandwiches.count >= 3
      # end

      # grant_on 'sandwiches#create', badge_id: 6, to: :user do |sandwich|
      #   sandwich.user.sandwiches.count >= 4
      # end
    end
  end
end
