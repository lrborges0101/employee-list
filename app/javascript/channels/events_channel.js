import consumer from "./consumer"

consumer.subscriptions.create("EventsChannel", {
  connected() {
  },
  
  disconnected() {
  },

  received(data) {
    // Called when there's incoming data on the websocket for this channel
    const event = new CustomEvent("newEvent", {detail: data});
    window.dispatchEvent(event); 
  }
});
