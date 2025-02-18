import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="favorite-toggle"
export default class extends Controller {
  static targets = ["unliked"]

  connect() {
    console.log("Hello, This is the favorite toggle!")
    this.showingFavorites = false;  // Initially, we're showing all sandwiches
  }

  fire() {
    const favoriteIds = JSON.parse(this.element.getAttribute("data-favorite-toggle-favorites"))
    console.log("Button clicked!"); // Check if click works

    // Toggle the state
    this.showingFavorites = !this.showingFavorites;

    if (this.showingFavorites) {
      // When showing only favorites, remove non-favorites from the DOM
      this.unlikedTargets.forEach(target => {
        const sandwichId = target.getAttribute('data-id'); // Get sandwich ID

        if (!favoriteIds.includes(parseInt(sandwichId))) {
          console.log(`Removing sandwich ID: ${sandwichId}`);
          target.closest(".col-6, .col-md-4").remove(); // Removes the grid column
        }
      });
    } else {
      // Reload the page to restore all sandwiches (simpler than manually reinserting elements)
      location.reload();
    }
  }
}
