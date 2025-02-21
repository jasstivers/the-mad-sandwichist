import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="search"
export default class extends Controller {
  static targets = ["input", "results"];

  fire(event) {
    event.preventDefault();

    const query = encodeURIComponent(this.inputTarget.value.trim());  // Encode search query
    if (query === "") return; // Prevent empty searches

    const url = "/sandwiches?query=" + query; // Update with correct endpoint if necessary
    console.log("Fetching:", url);

    fetch(url, {
      method: "GET",
      headers: { "Accept": "text/plain" }
    })
    .then(response => response.text())
    .then((data) => {
      console.log("Search results updated");
      this.resultsTarget.innerHTML = data;
    })
    .catch(error => console.error("Search error:", error));
  }
}
