import { Controller } from "@hotwired/stimulus"
export default class extends Controller {
  static targets = ["previewContainer", "previewImage"]

  connect() {
    console.log("Image preview controller connected")
  }

  showPreview(event) {
    const file = event.target.files[0]
    const reader = new FileReader()

    reader.onloadend = () => {
      this.previewImageTarget.src = reader.result
      this.previewImageTarget.style.display = "block"
    }

    if (file) {
      reader.readAsDataURL(file)
    } else {
      this.previewImageTarget.style.display = "none"
    }
  }
}
