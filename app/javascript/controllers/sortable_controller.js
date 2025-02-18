import { Controller } from "@hotwired/stimulus"
import Sortable from "sortablejs";
import { put } from "@rails/request.js";


export default class extends Controller {
  connect() {
    // super.connect()
    console.log("Do what you want here.")
    console.log(this.element)

    // // The sortable.js instance.
    // this.sortable

    // // Your options
    // this.options

    // // Your default options
    // this.defaultOptions
    Sortable.create(this.element, {
      ghostClass: "ghost",
      group: "sortable",
      animation: 150
    });
  }

  // You can override the `onUpdate` method here.
  onUpdate(event) {
    console.log("Drag", event)
    super.onUpdate(event)
  }

  // You can set default options in this getter for all sortable elements.
  get defaultOptions() {
    return {
      animation: 500,
    }
  }
}
