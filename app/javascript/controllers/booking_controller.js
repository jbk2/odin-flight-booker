import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="booking"
export default class extends Controller {
  static values = { url: String }

  connect() {
    console.log("Booking controller connected");
  }

  goToUrl() {
    Turbo.visit(this.urlValue)
  }
}
