class ReviewsController < ApplicationController
  before_action :set_sandwich, only: [:index, :create]

  def index
    @reviews = @sandwich.reviews
    render json: @reviews
  end

  def create
    @review = @sandwich.reviews.build(review_params)
    @review.username ||= current_user.username

    if @review.save
      render json: @review, status: :created
    else
      render json: { error: "Failed to save review" }, status: :unprocessable_entity
    end
  end

  def destroy
    @review = Review.find(params[:id])
    if @review.destroy
      render json: { message: "Review deleted" }
    else
      render json: { error: "Failed to delete review" }, status: :unprocessable_entity
    end
  end

  private

  def set_sandwich
    @sandwich = Sandwich.find(params[:sandwich_id])
  end

  def review_params
    params.require(:review).permit(:username, :review_text, :star_rating, :crazy_rating, :sandwich_id)
  end
end
