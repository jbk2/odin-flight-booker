import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="welcome-modal"
export default class extends Controller {
  connect() {
    console.log('Welcome modal connected');
  }

  removeModal() {
    console.log('removeModal function activated');
    this.element.remove();
  }
}
