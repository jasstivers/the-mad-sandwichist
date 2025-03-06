import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["starRating", "crazyRating", "commentBox", "reviewsList", "noReviewsMessage", "username"];
  static values = { sandwichId: Number }

  connect() {
    this.sandwichIdValue = this.element.dataset.reviewSandwichId;
    this.selectedStarRating = 0;
    this.selectedCrazyRating = 0;
    this.loadReviews();
  }

  selectRating(event) {
    this.selectedStarRating = event.currentTarget.dataset.value;
    this.updateRatingDisplay(this.starRatingTarget, this.selectedStarRating, "fa-star");
  }

  selectCraziness(event) {
    this.selectedCrazyRating = event.currentTarget.dataset.value;
    this.updateRatingDisplay(this.crazyRatingTarget, this.selectedCrazyRating, "fa-bolt");
  }

  updateRatingDisplay(parent, rating, iconClass) {
    let icons = parent.querySelectorAll("i");
    icons.forEach(icon => {
      icon.classList.remove("text-warning");
      if (icon.dataset.value <= rating) {
        icon.classList.add("text-warning");
      }
    });
  }

  async submitReview() {
    const reviewText = this.commentBoxTarget.value.trim();
    const username = this.usernameTarget.value;

    if (this.selectedStarRating === 0 || this.selectedCrazyRating === 0 || reviewText === "") {
      alert("Please fill out all fields before submitting your review.");
      return;
    }

    const review = {
      username: username,
      review_text: reviewText,
      star_rating: this.selectedStarRating,
      crazy_rating: this.selectedCrazyRating,
      sandwich_id: this.sandwichIdValue
    };

    const csrfToken = document.querySelector('meta[name="csrf-token"]').content;

    try {
      const response = await fetch(`/sandwiches/${this.sandwichIdValue}/reviews`, {
        method: "POST",
        headers: {
          "Content-Type": "application/json",
          "X-CSRF-Token": csrfToken
        },
        body: JSON.stringify({ review })
      });

      if (!response.ok) {
        const errorResponse = await response.json();
        console.error("Error response:", errorResponse);
        throw new Error("Failed to submit review");
      }

      const newReview = await response.json();
      this.addReviewToList(newReview);
      this.resetReviewForm();
    } catch (error) {
      console.error(error);
    }
  }

  addReviewToList(review) {
    const template = document.querySelector("#review-template");
    if (!template) return;

    const reviewElement = template.content.cloneNode(true);
    reviewElement.querySelector(".review-username").textContent = review.username;
    reviewElement.querySelector(".stars").textContent = "⭐".repeat(review.star_rating);
    reviewElement.querySelector(".craziness").textContent = "⚡".repeat(review.crazy_rating);
    reviewElement.querySelector(".review-text").textContent = review.review_text;

    const reviewContainer = reviewElement.querySelector(".review-item");
    reviewContainer.dataset.reviewId = review.id;
    reviewElement.querySelector(".delete-btn").dataset.id = review.id;
    reviewElement.querySelector(".delete-btn").dataset.userId = review.user_id;

    this.reviewsListTarget.appendChild(reviewElement);

    if (this.reviewsListTarget.children.length > 0) {
      this.noReviewsMessageTarget.style.display = "none";
    }
  }

  async deleteReview(event) {
    const reviewId = event.currentTarget.dataset.id;
    const csrfToken = document.querySelector('meta[name="csrf-token"]').content;

    try {
      const response = await fetch(`/sandwiches/${this.sandwichIdValue}/reviews/${reviewId}`, {
        method: "DELETE",
        headers: {
          "Content-Type": "application/json",
          "X-CSRF-Token": csrfToken
        }
      });
      if (!response.ok) throw new Error("Failed to delete review");

      const reviewToDelete = this.reviewsListTarget.querySelector(`[data-review-id='${reviewId}']`);
      if (reviewToDelete) reviewToDelete.remove();

      if (this.reviewsListTarget.children.length === 0) {
        this.noReviewsMessageTarget.style.display = "block";
      }
    } catch (error) {
      console.error(error);
    }
  }

  async loadReviews() {
    try {
      const response = await fetch(`/sandwiches/${this.sandwichIdValue}/reviews`);
      if (!response.ok) throw new Error("Failed to load reviews");

      const reviews = await response.json();
      if (reviews.length === 0) {
        this.noReviewsMessageTarget.style.display = "block";
      } else {
        reviews.forEach(review => this.addReviewToList(review));
        this.noReviewsMessageTarget.style.display = "none";
      }
    } catch (error) {
      console.error(error);
    }
  }

  resetReviewForm() {
    this.commentBoxTarget.value = "";
    this.selectedStarRating = 0;
    this.selectedCrazyRating = 0;
    this.updateRatingDisplay(this.starRatingTarget, 0, "fa-star");
    this.updateRatingDisplay(this.crazyRatingTarget, 0, "fa-bolt");
  }
}
