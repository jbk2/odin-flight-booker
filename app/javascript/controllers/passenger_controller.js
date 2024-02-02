import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["form"]
  
  initialize() {
    this.minPassengers = 1;
    this.maxPassengers = 5;
    this.passengerCount = this.formTarget.querySelectorAll('li').length;
    this.delayValue = 300;
  }
  
  connect() {
    console.log(`Form target found; ${this.hasFormTarget}`);
    this.updateButtonVisibility();
  }

  add(event) {
    console.log("add button activated #add")
    event.preventDefault();
    if (this.passengerCount < this.maxPassengers) {
      this.passengerCount++;
      const newPassenger = this.formTarget.querySelector('li').cloneNode(true);
      newPassenger.querySelector('input[name*="name"]').value = '';
      newPassenger.querySelector('input[name*="email"]').value = '';
      newPassenger.querySelector('span').textContent = `Passenger no.${this.passengerCount} - `;
      newPassenger.classList.add('transition-all', `duration-${this.delayValue}`, 'opacity-0', 'transform', 'scale-95');
      this.formTarget.appendChild(newPassenger);
      setTimeout(() => {
        newPassenger.classList.remove('opacity-0', 'scale-95')
        newPassenger.classList.add('opacity-100', 'scale-100') }
        , 50);
      this.updateButtonVisibility();
      console.log(`passengerCount is; ${this.passengerCount}`)
    }
  }

  remove(event) {
    console.log("remove button activated #remove")
    event.preventDefault();
    if (this.passengerCount > this.minPassengers) {
      this.passengerCount--
      const lastPassenger = this.formTarget.querySelector('li:last-child')
      setTimeout(() => {
      lastPassenger.classList.remove('opacity-100', 'scale-100')
      lastPassenger.classList.add('opacity-0', 'scale-90') }
      , 50);
      setTimeout(() => {
        this.formTarget.removeChild(lastPassenger) }
        , this.delayValue - 80);
      this.updateButtonVisibility();
      console.log(`passengerCount is; ${this.passengerCount}`)
    }
  }

  updateButtonVisibility() {
    const addButton = this.element.querySelector('[data-action="passenger#add"]');
    const removeButton = this.element.querySelector('[data-action="passenger#remove"]');

    const changeVisibility = (button, shouldBeVisible) => {
        button.style.transition = 'opacity 0.5s';
        button.style.opacity = shouldBeVisible ? '1' : '0';

        setTimeout(() => {
            button.style.visibility = shouldBeVisible ? 'visible' : 'hidden';
        }, 500);
    };

    if (this.passengerCount >= this.maxPassengers) {
        changeVisibility(addButton, false);
    } else {
        addButton.style.visibility = 'visible';
        changeVisibility(addButton, true);
    }

    if (this.passengerCount <= this.minPassengers) {
        changeVisibility(removeButton, false);
    } else {
        removeButton.style.visibility = 'visible';
        changeVisibility(removeButton, true);
    }
}


  
  
}