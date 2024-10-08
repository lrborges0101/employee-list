class EventsController < ApplicationController
  include Pagy::Backend
  
  before_action :mark_events_as_read, only: [:index]

  def index
    @pagy, @events = pagy(Event.order(created_at: :desc), limit: 20)
  end

  private
    def mark_events_as_read
      Event.where(read: false).update_all(read: true)
    end
end
