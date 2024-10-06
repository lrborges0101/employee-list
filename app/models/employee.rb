class Employee < ApplicationRecord
  has_many :events, dependent: :destroy

  after_create :register_create_event
  after_update :register_update_event

  scope :by_recently_created, -> { order(created_at: :desc) }

  private

  def register_create_event
    Event.create!(
      title: "Employee #{self.id} has been created",
      employee_id: self.id,
      event_type: 'created',
      read: false
    )
  end

  def register_update_event
    Event.create!(
      title: "Employee #{self.id} has been updated",
      employee_id: self.id,
      event_type: 'updated',
      read: false
    )
  end
end
