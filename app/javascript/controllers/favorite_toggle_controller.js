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
      // When showing only favorites, hide non-favorites
      this.unlikedTargets.forEach(target => {
        const sandwichId = target.getAttribute('data-id'); // Get sandwich ID

        if (favoriteIds.includes(parseInt(sandwichId))) {
          // If it's a favorite, unhide it
          console.log(`Unhiding sandwich ID: ${sandwichId}`);
          target.classList.remove("d-none");
        } else {
          // If it's NOT a favorite, hide it
          console.log(`Hiding sandwich ID: ${sandwichId}`);
          target.classList.add("d-none");
        }
      });
    } else {
      // When showing all sandwiches, make them all visible
      this.unlikedTargets.forEach(target => {
        console.log(`Showing sandwich ID: ${target.getAttribute('data-id')}`);
        target.classList.remove("d-none");  // Remove d-none to show everything
      });
    }
  }
}
