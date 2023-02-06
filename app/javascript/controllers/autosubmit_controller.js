import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  submitForm(event) {
    this.element.submit();
  }
}
