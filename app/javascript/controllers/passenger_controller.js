import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["form", "count"]
  
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

  // Add passenger field on booking form
  add(event) {
    console.log("add button activated #add")
    event.preventDefault();
    if (this.passengerCount < this.maxPassengers) {
      this.passengerCount++;
      const newPassenger = this.formTarget.querySelector('li').cloneNode(true);
      const newIndex = this.passengerCount - 1;

      // clear input fields
      const inputs = newPassenger.querySelectorAll('input');
      inputs.forEach(input => {
        input.value = '';
      // Index name attribute correctly
        const nameAttr = input.getAttribute('name');
        if (nameAttr) {
          input.setAttribute('name', nameAttr.replace(/\[\d+\]/, `[${newIndex}]`));
        }
      // Index id attribute correctly
        const idAttr = input.getAttribute('id');
        if (idAttr) {
          input.setAttribute('id', idAttr.replace(/_\d+_/, `_${newIndex}_`));
        }
      });
      // Index label for attribute correctly
      const labels = newPassenger.querySelectorAll('label');
      labels.forEach(label => {
        const forAttr = label.getAttribute('for');
        if (forAttr) {
          label.setAttribute('for', forAttr.replace(/_\d+_/, `_${newIndex}_`));
        }
      });

      // Add new passenger span label and add fade in classes
      newPassenger.querySelector('span').textContent = `Passenger no.${this.passengerCount} - `;
      newPassenger.classList.add('transition-all', `duration-${this.delayValue}`, 'opacity-0', 'transform', 'scale-95');

      // Add new passenger to the form and make visible
      this.formTarget.appendChild(newPassenger);
      setTimeout(() => {
        newPassenger.classList.remove('opacity-0', 'scale-95')
        newPassenger.classList.add('opacity-100', 'scale-100') }
        , 50);

        // Update button visibility
      this.updateButtonVisibility();
      console.log(`passengerCount is; ${this.passengerCount}`)
    }
  }

  // Remove passenger field on booking form
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