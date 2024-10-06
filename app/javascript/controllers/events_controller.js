import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="events"
export default class extends Controller {
  static targets = ["notification"];

  connect() {
    // Initialize newEvents with the unread count from the server
    this.newEvents = parseInt(this.notificationTarget.innerText, 10) || 0;

    // Display the initial count if any
    this.showNotification();

    window.addEventListener("newEvent", (e) => {
      this.newEvents += 1;
      this.showNotification();
    });
  }

  disconnect() {
    window.removeEventListener("newEvent", this.showNotification);
  }

  showNotification() {
    this.notificationTarget.innerText = `${this.newEvents}`;
  }
}

