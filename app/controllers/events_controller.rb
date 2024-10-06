class EventsController < ApplicationController
  include Pagy::Backend
  
  def index
    @pagy, @events = pagy(Event.order(created_at: :desc), limit: 20)
    Event.where(read: false).update_all(read: true)
  end
end
