import { Application } from "@hotwired/stimulus"
import FlightSearchFormController from "./flight_search_form_controller"

const application = Application.start()

// Configure Stimulus development experience
application.debug = false
window.Stimulus   = application

application.register("flight-search-form", FlightSearchFormController)

export { application }