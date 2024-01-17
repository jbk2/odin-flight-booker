import { Controller } from "@hotwired/stimulus"
import { Turbo } from "@hotwired/turbo-rails"

export default class extends Controller {
  connect() {
    console.log("**********Airport Select Controller connected**********");
    this.element.addEventListener('change', this.updateAirports.bind(this));
  }

  updateAirports(event) {
    const departure_country = event.target.value;
    const url = `/flights/update_airports?departure_country=${departure_country}`;
    console.log("********** - The Stimulus controller has obtained the departure country;", departure_country);
    console.log("Event Type:", event.type); // Log the event type (e.g., "change")
    console.log("Target Value:", departure_country); // Log the value of the target element
    console.log("Event Object:", event); // Log the entire event object (for more detailed inspection)


    fetch(url, {
      headers: {
        'Accept': 'text/vnd.turbo-stream.html'
      }
    }).then(response => response.text())
      .then(html => Turbo.renderStreamMessage(html));
  }
}
