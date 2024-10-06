class Event < ApplicationRecord
  belongs_to :employee

  after_create :broadcast_new_event 

  def self.unread_count
    where(read: false).count
  end

  private
  def broadcast_new_event
    ActionCable.server.broadcast "events_channel", {
      title: title,
      employee_id: employee.id,
      created_at: created_at.strftime("%d/%m/%Y %H:%M"),
      event_type: event_type
    }
  end
end
