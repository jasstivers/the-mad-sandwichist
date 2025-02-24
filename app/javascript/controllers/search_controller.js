import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="search"
export default class extends Controller {
  static targets = ["input", "results"];

  fire(event) {
    event.preventDefault();

    const query = this.inputTarget.value.trim();
    const url = query === "" ? "/sandwiches" : `/sandwiches?query=${encodeURIComponent(query)}`;

    console.log("Fetching:", url);

    fetch(url, {
      method: "GET",
      headers: { "Accept": "text/vnd.turbo-stream.html" } // Turbo Stream format
    })
    .then(response => response.text())
    .then((data) => {
      console.log("Search results updated");

      // Ensure resultsTarget is found before updating
      if (this.resultsTarget) {
        this.resultsTarget.innerHTML = data; // Ensure correct replacement
      } else {
        console.error("Results target not found!");
      }
    })
    .catch(error => console.error("Search error:", error));
  }
}
