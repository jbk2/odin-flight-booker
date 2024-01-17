import { Application } from "@hotwired/stimulus"
import CountrySelectController from "./country_select_controller"

const application = Application.start()

// Configure Stimulus development experience
application.debug = false
window.Stimulus   = application

application.register("country-select", CountrySelectController)

export { application }