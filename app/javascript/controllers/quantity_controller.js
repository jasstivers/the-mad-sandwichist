import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["slider", "display"]

  connect() {
    // Initially set the display for each slider
    this.sliderTargets.forEach(slider => {
      this.updateDisplay(slider);
    });
  }

  update(event) {
    // Handle slider update event
    this.updateDisplay(event.target);
  }

  updateDisplay(slider) {
    // Find the corresponding display element for the slider
    const display = slider.closest('div').querySelector('.ingredient-quantity-display');

    if (display) {
      const singular = display.dataset.singular;
      const plural = display.dataset.plural;
      const quantity = slider.value;

      // Update the display text with pluralization logic
      display.textContent = `${quantity} ${quantity > 1 ? plural : singular}`;
    }
  }
}
