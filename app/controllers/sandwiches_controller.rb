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
    @sandwiches = Sandwich.all
  end


  def new
    @sandwich = Sandwich.new
    @ingredients = Ingredient.all
  end

  def create
    @sandwich = Sandwich.new(sandwich_params)
    @sandwich.user = @user  # Ensure the sandwich is associated with the current user

    if @sandwich.save
      redirect_to @sandwich, notice: "Sandwich created successfully!"
    else
      @ingredients = Ingredient.all
      render :new, status: :unprocessable_entity
    end
  end

  def show
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
    params.require(:sandwich).permit(:name, ingredient_ids: [])
  end
end
