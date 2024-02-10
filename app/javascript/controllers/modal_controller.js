import { Controller } from "@hotwired/stimulus"
export default class extends Controller {

  static targets = ["passengerPassword", "eye", "eyeSlash", "passwordIconDiv", "passengerConfirmationPassword", "confirmationEye", "confirmationEyeSlash", "confirmationPasswordIconDiv"]
  
  connect() {
    this.element.querySelector('dialog').showModal();
  }

  toggleVisibility(event) {
    const iconDivTarget = event.target.closest('[data-modal-target="passwordIconDiv"], [data-modal-target="confirmationPasswordIconDiv"]');
    const isPassword = iconDivTarget.dataset.modalTarget === 'passwordIconDiv';
    const fieldTarget = isPassword ? this.passengerPasswordTarget : this.passengerConfirmationPasswordTarget;
    const eyeIcon = fieldTarget === this.passengerPasswordTarget ? this.eyeTarget : this.confirmationEyeTarget;
    const eyeSlashIcon = fieldTarget === this.passengerPasswordTarget ? this.eyeSlashTarget : this.confirmationEyeSlashTarget;

    fieldTarget.type = fieldTarget.type === "password" ? "text" : "password";

    eyeIcon.classList.toggle("invisible", fieldTarget.type === "text");
    eyeIcon.classList.toggle("visible", fieldTarget.type === "password");
    eyeSlashIcon.classList.toggle("invisible", fieldTarget.type === "password");
    eyeSlashIcon.classList.toggle("visible", fieldTarget.type === "text");
  }

}
