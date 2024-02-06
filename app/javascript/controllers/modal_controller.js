import { Controller } from "@hotwired/stimulus"
export default class extends Controller {

  static targets = ["password"]
  
  connect() {
    console.log("Modal controller connected");
    console.log(`Password target found; ${this.hasPasswordTarget}`);
    this.element.querySelector('dialog').showModal();
  }

  showPassword() {
    if (this.passwordTarget.type === "password") {
      this.passwordTarget.type = "text";
    } else {
      this.passwordTarget.type = "password";
    }
  }

}
