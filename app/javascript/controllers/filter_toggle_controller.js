import { Controller } from "stimulus";

export default class extends Controller {
  static targets = ["sandwiches", "button"];

  connect() {
    this.showingFavorites = false;  // Initially, show all sandwiches
    console.log("FilterToggleController connected");
  }

  toggle() {
    this.showingFavorites = !this.showingFavorites;
    this.buttonTarget.classList.toggle("active", this.showingFavorites);
    this.filterSandwiches();
  }

  filterSandwiches() {
    if (this.showingFavorites) {
      // Filter to only show favorites
      const favoriteIds = this.data.get("favoriteIds").split(",");
      this.sandwichesTargets.forEach((sandwich) => {
        const sandwichId = sandwich.dataset.sandwichId;
        sandwich.style.display = favoriteIds.includes(sandwichId) ? "block" : "none";
      });
    } else {
      // Show all sandwiches
      this.sandwichesTargets.forEach(sandwich => {
        sandwich.style.display = "block";
      });
    }
  }
}
