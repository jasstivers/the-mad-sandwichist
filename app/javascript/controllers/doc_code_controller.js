import { Controller } from "@hotwired/stimulus";
export default class extends Controller {
  static targets = ["docCode"];

  connect() {
    this.setDocCode();
  }

  generateRandomDocCode() {
    const randomNumber = Math.floor(Math.random() * 9000) + 1000;

    const randomLetters = Array.from({ length: 3 }, () =>
      String.fromCharCode(65 + Math.floor(Math.random() * 26))
    ).join("");

    return `${randomNumber}.${randomLetters}`;
  }

  setDocCode() {
    const docCode = this.generateRandomDocCode();
    this.docCodeTarget.innerText = docCode;
  }
}
