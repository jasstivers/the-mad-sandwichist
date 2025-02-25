import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["icon"];

  connect() {
    this.updateHeart();
  }

  async toggle(event) {
    event.preventDefault();
    const sandwichId = this.element.dataset.favoriteId;
    const isFavorited = this.element.dataset.favoriteState === "true"; // Ensure it's read as a boolean

    try {
      let response;
      if (isFavorited) {
        response = await fetch(`/favorites/${sandwichId}`, {
          method: "DELETE",
          headers: {
            "Content-Type": "application/json",
            "X-CSRF-Token": document.querySelector("[name='csrf-token']").content, // Ensure CSRF token is passed
          },
        });
      } else {
        response = await fetch("/favorites", {
          method: "POST",
          headers: {
            "Content-Type": "application/json",
            "X-CSRF-Token": document.querySelector("[name='csrf-token']").content, // Ensure CSRF token is passed
          },
          body: JSON.stringify({ sandwich_id: sandwichId }),
        });
      }

      if (response.ok) {
        // Toggle favorite state
        this.element.dataset.favoriteState = (!isFavorited).toString();
        this.updateHeart();
      } else {
        console.error("Failed to toggle favorite", response.statusText);
      }
    } catch (error) {
      console.error("Failed to toggle favorite", error);
    }
  }

  updateHeart() {
    const isFavorited = this.element.dataset.favoriteState === "true";

    this.element.innerHTML = isFavorited
      ? '<i class="fa-solid fa-heart text-danger"></i>' // Favorited: Solid red heart
      : '<i class="fa-regular fa-heart"></i>'; // Unfavorited: Regular black heart
  }
}
