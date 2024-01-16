import { Application } from "@hotwired/stimulus"
import AirportSelectController from "./airport_select_controller"

const application = Application.start()

// Configure Stimulus development experience
application.debug = false
window.Stimulus   = application

application.register("airport-select", AirportSelectController)

export { application }