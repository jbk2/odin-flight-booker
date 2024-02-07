import { Controller } from "@hotwired/stimulus"
export default class extends Controller {

  static targets = ["passengerPassword", "eye", "eyeSlash", "iconDiv"]
  
  connect() {
    console.log("Modal controller connected");
    console.log(`passengerPassword target found; ${this.hasPassengerPasswordTarget}`);
    console.log(`Eye target found; ${this.hasEyeTarget}`);
    console.log(`Eye-slash target found; ${this.hasEyeSlashTarget}`);
    console.log(`Icon-Div target found; ${this.hasIconDivTarget}`);
    this.element.querySelector('dialog').showModal();
  }

  toggleIcon() {
    const passwordField = this.passengerPasswordTarget;
    const eyeIcon = this.eyeTarget;
    const eyeSlashIcon = this.eyeSlashTarget;
    const iconDiv = this.iconDivTarget;

    if (passwordField.type === "password") {
      passwordField.type = "text";
      eyeSlashIcon.classList.remove("invisible");
      eyeSlashIcon.classList.add("visible");
      eyeIcon.classList.remove("visible");
      eyeIcon.classList.add("invisible");
    } else {
      passwordField.type = "password";
      eyeIcon.classList.remove("invisible");
      eyeIcon.classList.add("visible");
      eyeSlashIcon.classList.remove("visible");
      eyeSlashIcon.classList.add("invisible");
    }
  }

}
