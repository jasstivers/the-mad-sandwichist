class FavoritesController < ApplicationController
  def create
    sandwich = Sandwich.find(params[:sandwich_id])
    current_user.favorite(sandwich)
    head :ok
  end

  def destroy
    sandwich = Sandwich.find(params[:id])
    current_user.unfavorite(sandwich)
    head :ok
  end
end
