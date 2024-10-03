class Employee < ApplicationRecord
  scope :by_recently_created, -> { order(created_at: :desc) }
end
