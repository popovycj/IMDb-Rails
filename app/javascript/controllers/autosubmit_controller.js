import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  submitForm(event) {
    this.element.requestSubmit()
  }

  search() {
    clearTimeout(this.timeout)
    this.timeout = setTimeout(() => {
      this.submitForm()
    }, 200)
  }
}
