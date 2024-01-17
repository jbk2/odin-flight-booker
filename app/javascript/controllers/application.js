import { Application } from "@hotwired/stimulus"
import DepartureCountrySelectController from "./departure_country_select_controller"

const application = Application.start()

// Configure Stimulus development experience
application.debug = false
window.Stimulus   = application

application.register("departure-country-select", DepartureCountrySelectController)

export { application }