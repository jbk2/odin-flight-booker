import { Controller } from "@hotwired/stimulus"
import { Turbo } from "@hotwired/turbo-rails"

export default class extends Controller {
  static targets = ["departure_country", "arrival_country", "departure_airport", "arrival_airport"]
  
  connect() {
    // this.element.addEventListener('change', this.updateAirports.bind(this));
    console.log("**********Flight Search Form Controller connected**********");
    this.departure_countryTarget.addEventListener('change', (event) => this.updateAirports(event, 'departure_country'));
    this.arrival_countryTarget.addEventListener('change', (event) => this.updateAirports(event, 'arrival_country'));
    this.departure_airportTarget.addEventListener('change', (event) => this.updateDepartureDates(event, 'departure_airport'));
    this.arrival_airportTarget.addEventListener('change', (event) => this.updateDepartureDates(event, 'arrival_airport'));
  }

  updateAirports(event, type) {
    const selectedCountry = event.target.value;
  
    const url = type === 'departure_country' 
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

  updateDepartureDates(event, type) {   
    console.log(`##################Beginning update of date field with dates`);
    console.log(`################## Evenet: ${event}`);
    console.log(`################## Type: ${type}`);
    console.log("##################Beginning update of date field with dates");
    console.log("Departure airport value: ", this.departure_airportTarget.value);
    console.log("Arrival airport value: ", this.arrival_airportTarget.value);

    const selectedDepartureAirport = this.departure_airportTarget.value;
    const selectedArrivalAirport = this.arrival_airportTarget.value;

    if (selectedDepartureAirport && selectedArrivalAirport) {
      const url = `/flights/update_departure_dates?departure_airport_id=${selectedDepartureAirport}&arrival_airport_id=${selectedArrivalAirport}`;
      console.log(`Updating departure dates with departure airport: ${selectedDepartureAirport} and arrival airport: ${selectedArrivalAirport}`);
    
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
