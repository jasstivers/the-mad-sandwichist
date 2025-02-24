import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="search"
export default class extends Controller {
  static targets = ["input", "results"];

  fire(event) {
    event.preventDefault();
    this.resultsTarget.classList.add("loading"); // Fade out slightly

    const query = this.inputTarget.value.trim();
    const url = query === "" ? "/sandwiches" : `/sandwiches?query=${encodeURIComponent(query)}`;

    fetch(url, {
      method: "GET",
      headers: { "Accept": "text/vnd.turbo-stream.html" }
    })
    .then(response => response.text())
    .then((data) => {
      this.resultsTarget.innerHTML = data;
      this.resultsTarget.classList.remove("loading"); // Remove fade effect
    })
    .catch(error => console.error("Search error:", error));
  }
}
