import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["aiQuantity", "keyword", "responseBox", "container"]

  connect() {
    console.log("this is testing if the generate is connected");
  }

  generate(event) {
    console.log("This is a test of my ability to pay attention to details...");
    event.preventDefault()
    const baseUrl = window.location.origin
    const csrfToken = document.querySelector('meta[name="csrf-token"]').content;
    fetch(`${baseUrl}/generate_suggestion`, {
      method: "POST", // Could be dynamic with Stimulus values
      headers: { "Content-Type": "application/json", 'X-CSRF-Token': csrfToken },
      body: JSON.stringify({ quantity: this.aiQuantityTarget.value , keyword: this.keywordTarget.value})
    })
      .then(response => response.json())
      .then((data) => {
        this.aiQuantityTarget.value = 1
        this.keywordTarget.value = ""
        this.responseBoxTarget.value = ""
        console.log(data)
        const suggestion_list = JSON.parse(data.result)
        suggestion_list.forEach((ingredient) =>{
          const templateId = `ingredient-template-${ingredient[1]}`
          const template = document.getElementById(templateId).content.cloneNode(true)
          this.containerTarget.appendChild(template)
          this.responseBoxTarget.value += `${ingredient[0]}\n`
        })
      })
  }
};
