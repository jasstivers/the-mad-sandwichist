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

  submitReview() {
    const reviewText = this.commentBoxTarget.value.trim();
    const username = this.usernameTarget.value;

    if (this.selectedStarRating === 0 || this.selectedCrazyRating === 0 || reviewText === "") {
      alert("Please fill out all fields before submitting your review.");
      return;
    }

    const review = {
      id: Date.now(),
      username: username,
      starRating: this.selectedStarRating,
      crazyRating: this.selectedCrazyRating,
      reviewText: reviewText
    };

    this.saveReview(review);
    this.addReviewToList(review);

    this.selectedStarRating = 0;
    this.selectedCrazyRating = 0;
    this.commentBoxTarget.value = "";
    this.resetRatings();
  }

  addReviewToList(review) {
    const template = document.querySelector("#review-template");
    if (!template) return;

    const reviewElement = template.content.cloneNode(true);
    reviewElement.querySelector(".review-username").textContent = review.username;
    reviewElement.querySelector(".stars").textContent = "⭐".repeat(review.starRating);
    reviewElement.querySelector(".craziness").textContent = "⚡".repeat(review.crazyRating);
    reviewElement.querySelector(".review-text").textContent = review.reviewText;

    const reviewContainer = reviewElement.querySelector(".review-item");
    reviewContainer.dataset.reviewId = review.id;
    reviewElement.querySelector(".delete-btn").dataset.id = review.id;

    this.reviewsListTarget.appendChild(reviewElement);

    if (this.reviewsListTarget.children.length > 0) {
      this.noReviewsMessageTarget.style.display = "none";
    }
  }

  deleteReview(event) {
    const reviewId = Number(event.currentTarget.dataset.id);
    this.removeReviewFromStorage(reviewId);
    const reviewToDelete = this.reviewsListTarget.querySelector(`[data-review-id='${reviewId}']`);
    if (reviewToDelete) {
      reviewToDelete.remove();
    }

    if (this.reviewsListTarget.children.length === 0) {
      this.noReviewsMessageTarget.style.display = "block";
    }
  }

  saveReview(review) {
    let reviews = JSON.parse(localStorage.getItem(`reviews_${this.sandwichIdValue}`)) || [];
    reviews.push(review);
    localStorage.setItem(`reviews_${this.sandwichIdValue}`, JSON.stringify(reviews));
  }

  removeReviewFromStorage(reviewId) {
    let reviews = JSON.parse(localStorage.getItem(`reviews_${this.sandwichIdValue}`)) || [];
    reviews = reviews.filter(review => review.id !== reviewId);
    localStorage.setItem(`reviews_${this.sandwichIdValue}`, JSON.stringify(reviews));
  }

  loadReviews() {
    let reviews = JSON.parse(localStorage.getItem(`reviews_${this.sandwichIdValue}`)) || [];
    if (reviews.length > 0) {
      this.noReviewsMessageTarget.style.display = "none";
      reviews.forEach(review => this.addReviewToList(review));
    }
  }

  resetRatings() {
    this.updateRatingDisplay(this.starRatingTarget, 0, "fa-star");
    this.updateRatingDisplay(this.crazyRatingTarget, 0, "fa-bolt");
  }
}
