import { Controller } from "@hotwired/stimulus"
import { Turbo } from "@hotwired/turbo-rails"

export default class extends Controller {
  static targets = ["departure", "arrival"]
  
  connect() {
    // this.element.addEventListener('change', this.updateAirports.bind(this));
    this.departureTarget.addEventListener('change', (event) => this.updateAirports(event, 'departure'));
    this.arrivalTarget.addEventListener('change', (event) => this.updateAirports(event, 'arrival'));
    console.log("**********Country Select Controller connected**********");
  }


  updateAirports(event, type) {
    const selectedCountry = event.target.value;  // Correct variable name
  
    const url = type === 'departure' 
      ? `/flights/update_departure_airports?departure_country=${selectedCountry}`
      : `/flights/update_arrival_airports?arrival_country=${selectedCountry}`;
  
    console.log(`Updating ${type} airports with country: ${selectedCountry}`);
  
    fetch(url, {
      headers: {
        'Accept': 'text/vnd.turbo-stream.html'
      }
    }).then(response => response.text())
      .then(html => Turbo.renderStreamMessage(html));
  }
}
