import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["menu"]

  connect() {
    console.log("PopupMenuController is connected!");
    this.menuVisible = false;
  }

  toggle() {
    this.menuVisible = !this.menuVisible
    console.log("Toggling menu. Visibility:", this.menuVisible);
    if (this.menuVisible) {
      this.menuTarget.classList.add("show")
    } else {
      this.menuTarget.classList.remove("show")
    }
  }

  close(event) {
    if (!this.element.contains(event.target)) {
      this.menuVisible = false
      this.menuTarget.classList.remove("show")
    }
  }
}
