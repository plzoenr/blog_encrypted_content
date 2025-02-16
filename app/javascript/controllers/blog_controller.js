import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["content", "form"]

  edit() {
    this.contentTarget.classList.add("hidden")
    this.formTarget.classList.remove("hidden")
  }

  cancel() {
    this.contentTarget.classList.remove("hidden")
    this.formTarget.classList.add("hidden")
  }
}
