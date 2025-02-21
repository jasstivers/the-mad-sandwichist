import { Controller } from "@hotwired/stimulus";
import axios from "axios";

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
        response = await axios.delete(`/favorites/${sandwichId}`);
      } else {
        response = await axios.post(`/favorites`, { sandwich_id: sandwichId });
      }

      if (response.status === 200) {
        // Toggle favorite state
        this.element.dataset.favoriteState = (!isFavorited).toString();
        this.updateHeart();
      }
    } catch (error) {
      console.error("Failed to toggle favorite", error);
    }
  }

  updateHeart() {
    const isFavorited = this.element.dataset.favoriteState === "true";

    this.element.innerHTML = isFavorited
      ? `<i class="fa-solid fa-heart text-danger"></i>` // Favorited: Solid red heart
      : `<i class="fa-regular fa-heart"></i>`; // Unfavorited: Regular black heart
  }
}
