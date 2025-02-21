class SandwichesController < ApplicationController
  # skip_before_action :authenticate_user!, only: [:index]
  before_action :authenticate_user!, only: :toggle_favorite
  before_action :set_sandwich, only: %i[show]
  before_action :set_user, only: %i[create]  # Set the current user

  def toggle_favorite
    # @sandwiches = Sandwich.all
    @sandwich = Sandwich.find_by(id: params[:id])
    if current_user.favorited?(@sandwich)
      current_user.unfavorite(@sandwich)
    else
      current_user.favorite(@sandwich)
    end
    redirect_to sandwiches_path
  end

    def index
      if params[:query].present?
        @sandwiches = Sandwich.where("name ILIKE ?", "%#{params[:query]}%")
      else
        @sandwiches = Sandwich.all
      end

      respond_to do |format|
        format.html
        format.text { render partial: "sandwiches/sandwich_cards", locals: { sandwiches: @sandwiches }, formats: [:html] }
      end
    end

  def new
    @sandwich = Sandwich.new
    @default_ingredients = [
      "Pretzel Bun",
      "Beef Patty",
      "Sliced Cheddar Cheese",
      "Ketchup",
      "Pretzel Bun (bottom)"
    ]

    @visible_ingredients = Ingredient.where(name: @default_ingredients)
      .sort_by { |ing| @default_ingredients.index(ing.name) }
  end

  def create
    @sandwich = Sandwich.new(sandwich_params.slice(:name, :description, :photo))
    @sandwich.user = @user  # Ensure the sandwich is associated with the current user
    if @sandwich.save
      sandwich_params[:ingredient_ids].each_with_index do |ingredient_id, index|
        @ingredient = Ingredient.find(ingredient_id)
        @ingredient_quantities = sandwich_params[:ingredient_quantities]
        SandwichIngredient.create(sandwich: @sandwich, ingredient: @ingredient, ingredient_position: index, ingredient_qty: @ingredient_quantities[ingredient_id])
      end
      redirect_to @sandwich, notice: "Sandwich created successfully!"
    else
      @ingredients = Ingredient.all
      @visible_ingredients = Ingredient.where(name: @default_ingredients)
      .sort_by { |ing| @default_ingredients.index(ing.name) }
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @sandwich = Sandwich.find(params[:id])

    @sandwich_ingredients = SandwichIngredient.where(sandwich_id: @sandwich.id).order(:ingredient_position)

    @flavors = @sandwich_ingredients.flat_map { |sandwich_ingredient| sandwich_ingredient.ingredient.traits.where(trait_type: "flavor").pluck(:name) }
    @textures = @sandwich_ingredients.flat_map { |sandwich_ingredient| sandwich_ingredient.ingredient.traits.where(trait_type: "texture").pluck(:name) }
    @cuisines = @sandwich_ingredients.flat_map { |sandwich_ingredient| sandwich_ingredient.ingredient.traits.where(trait_type: "cuisine").pluck(:name) }
  end

  private

  # Set the current user
  def set_user
    @user = current_user
  end

  # Find a specific sandwich based on its ID
  def set_sandwich
    @sandwich = Sandwich.find(params[:id])
  end

  # Define permitted parameters for the sandwich form
  def sandwich_params
    params.require(:sandwich).permit(:name, :description, :photo, ingredient_ids: [], ingredient_quantities: {})
  end
end
