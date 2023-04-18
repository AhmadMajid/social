import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="vibration-polling"
export default class extends Controller {
  headers = { 'Accept': 'text/vnd.turbo-stream.html' };

  connect() {
    setInterval(() => {
      if (this.element.dataset.latestVibrationId.length > 0) {
        fetch(`/vibration_polling?latest_vibration_id=${this.element.dataset.latestVibrationId}`, { headers: this.headers })
        .then(response => response.text())
        .then(html => Turbo.renderStreamMessage(html))
      }
    }, 3000);
  }
}
