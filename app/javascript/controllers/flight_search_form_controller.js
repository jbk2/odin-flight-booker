import { Controller } from "@hotwired/stimulus"
import { Turbo } from "@hotwired/turbo-rails"

export default class extends Controller {
  static targets = ["departure_country", "arrival_country", "departure_airport", "arrival_airport"]
  
  connect() {
    console.log("**********Flight Search Form Controller is Connected**********");
  }

  updateAirports(event) {
    const targetElement = event.target;
    const selectedCountry = targetElement.value;
    const url = targetElement.name === 'departure_country' 
      ? `/flights/update_departure_airports?departure_country=${selectedCountry}`
      : `/flights/update_arrival_airports?arrival_country=${selectedCountry}`;
    console.log(`Updating ${targetElement.name} select with ${selectedCountry} only airports`);
  
    fetch(url, {
      headers: {
        'Accept': 'text/vnd.turbo-stream.html'
      }
    }).then(response => response.text())
      .then(html => Turbo.renderStreamMessage(html));
  }

  updateDepartureDates(event) {
    const targetElement = event.target;
    console.log(`##################updatDepartureDates function called`);
    const selectedDepartureAirport = this.departure_airportTarget.value;
    const selectedArrivalAirport = this.arrival_airportTarget.value;

    if (selectedDepartureAirport && selectedArrivalAirport) {
      const url = `/flights/update_departure_dates?departure_airport_id=${selectedDepartureAirport}&arrival_airport_id=${selectedArrivalAirport}`;
      console.log(`both airports chosen, therefore calling Flights#update_departure_dates with args;
        departure_airport_id: ${selectedDepartureAirport} and arrival_airport_id: ${selectedArrivalAirport}`);
    
      fetch(url, {
        headers: {
          'Accept': 'text/vnd.turbo-stream.html'
        }
      }).then(response => response.text())
      .then(html => Turbo.renderStreamMessage(html));
      console.log(`################Updated date field with dates`);
    }
  }
}
