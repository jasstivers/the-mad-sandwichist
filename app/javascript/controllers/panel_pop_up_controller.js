import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="panel-pop-up"
export default class extends Controller {
  connect() {
    console.log("connected")
  }
  popup(event) {
    console.log(event)
    let panel = this.element
    panel.classList.add("active")
    document.addEventListener("click", function (event) {
      if (!panel.contains(event.target)) { panel.classList.remove("active") }
    })
  }
}
