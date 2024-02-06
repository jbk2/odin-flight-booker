import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="modal"
export default class extends Controller {
  connect() {
    console.log("Modal controller connected");
    this.element.querySelector('dialog').showModal();
  }
}
