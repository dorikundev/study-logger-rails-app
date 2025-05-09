import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["option"]

  connect() {
    console.log("Color selector controller connected")
    this.initializeSelection()
  }

  initializeSelection() {
    const selectedRadio = this.element.querySelector('input[type="radio"]:checked')
    if (selectedRadio) {
      const color = selectedRadio.value
      this.highlightSelectedColor(color)
    }
  }

  select(event) {
    const clickedElement = event.currentTarget
    const radioInput = clickedElement.querySelector('input[type="radio"]')
    const color = clickedElement.querySelector('.color-select').dataset.color
    
    radioInput.checked = true
    this.highlightSelectedColor(color)
    radioInput.dispatchEvent(new Event('change', { bubbles: true }))
  }

  highlightSelectedColor(selectedColor) {
    this.optionTargets.forEach(option => {
      const colorDiv = option.querySelector('.color-select')
      if (colorDiv.dataset.color === selectedColor) {
        colorDiv.classList.add('border-gray-800')
        colorDiv.classList.remove('border-transparent')
      } else {
        colorDiv.classList.remove('border-gray-800')
        colorDiv.classList.add('border-transparent')
      }
    })
  }
}