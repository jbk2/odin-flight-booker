import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static values = { url: String }

  connect() {
    console.log("Booking controller connected");
  }

  // Called in Bookings index view to navigate to booking show
  goToUrl() {
    Turbo.visit(this.urlValue)
  }
}
