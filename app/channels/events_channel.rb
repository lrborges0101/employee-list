class EventsChannel < ApplicationCable::Channel
  def subscribed
    stream_from "events_channel"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def receive(data)
    ActionCable.server.broadcast("events_channel", data)
  end
end
