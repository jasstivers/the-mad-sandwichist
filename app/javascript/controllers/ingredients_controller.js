import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["remove", "listItem", "container", "select"]

  remove(event) {
    const index = this.removeTargets.findIndex(t => t === event.target);
    const listItemElement = this.listItemTargets[index];
    listItemElement.remove();
  }

  add(event) {
    console.log(this.selectTarget.value)
    const ingredientID = this.selectTarget.value
    event.preventDefault()
    const template = document.getElementById("ingredient-template-" + ingredientID);
    this.containerTarget.appendChild(template.content.cloneNode(true));
  }
};
