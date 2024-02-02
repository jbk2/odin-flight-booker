import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
    console.log("Flash controller connected")
    setTimeout(() => {
      this.fadeOut();
    }, 2000);
  }

  fadeOut() {
    this.element.classList.add('opacity-0', 'transition-opacity', 'duration-500');
    this.element.addEventListener('transitionend', () => {
      this.element.remove();
    }, { once: true });
  }
}
