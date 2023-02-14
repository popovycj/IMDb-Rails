import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = [ "preview" ]

  updatePreview(event) {
    const file = event.target.files[0]
    const reader = new FileReader()

    reader.onload = (e) => {
      this.previewTarget.parentElement.classList.remove("d-none")
      this.previewTarget.src = e.target.result
      this.previewTarget.style.maxWidth = '500px'
      this.previewTarget.style.maxHeight = '500px'
    }

    reader.readAsDataURL(file)
  }
}
