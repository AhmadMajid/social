import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="vibration-card"
export default class extends Controller {
  connect() {
    this.element.addEventListener('click', (e) => {
      if (![e.target.dataset.ignoreClick, e.target.parentElement.dataset.ignoreClick].includes('true')) {
        Turbo.visit(this.element.dataset.vibrationPath);
      }
    });
  }
}
