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
    const isFavorited = this.element.dataset.favoriteState === "true";

    try {
      // 发送 AJAX 请求
      let response;
      if (isFavorited) {
        response = await axios.delete(`/favorites/${sandwichId}`);
      } else {
        response = await axios.post(`/favorites`, { sandwich_id: sandwichId });
      }

      if (response.status === 200) {
        this.element.dataset.favoriteState = !isFavorited;
        this.updateHeart();
      }
    } catch (error) {
      console.error("Failed to toggle favorite", error);
    }
  }

  updateHeart() {
    if (this.element.dataset.favoriteState === "true") {
      this.element.innerHTML = `<i class="fa-solid fa-heart text-danger"></i>`; // 实心
    } else {
      this.element.innerHTML = `<i class="fa-regular fa-heart"></i>`; // 空心
    }
  }
}
