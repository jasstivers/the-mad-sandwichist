import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="favorite-toggle"
export default class extends Controller {
  static targets = ["unliked"]

  connect() {
    console.log("Hello, This is the favorite toggle!")
    this.favoriteIds = JSON.parse(this.element.getAttribute("data-favorite-toggle-favorites") || "[]")
    this.showingFavorites = false;  // Initially, we're showing all sandwiches
  }

  fire() {
    console.log("Favorites button clicked!")

    this.showingFavorites = !this.showingFavorites;

    if (this.showingFavorites) {
      console.log("Showing only favorites...");

      this.unlikedTargets.forEach(target => {
        const sandwichId = parseInt(target.dataset.id);

        if (!this.favoriteIds.includes(sandwichId)) {
          console.log(`Hiding sandwich ID: ${sandwichId}`);
          target.style.display = "none"; // Hide non-favorites instead of removing them
        }
      });
    } else {
      console.log("Showing all sandwiches...");
      this.unlikedTargets.forEach(target => {
        target.style.display = "flex"; // Show them again
      });
    }
  }
}
