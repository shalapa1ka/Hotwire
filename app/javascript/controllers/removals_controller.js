import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="removals"
export default class extends Controller {
  connect() {
    setTimeout(() => this.remove(), 10000)
  }

  remove() {
    this.element.remove()
  }
}
