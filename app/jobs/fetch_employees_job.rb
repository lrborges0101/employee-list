# app/jobs/fetch_employees_job.rb
class FetchEmployeesJob < ApplicationJob
  queue_as :default

  def perform
    token = ApiAuthenticationService.new.authenticate
    return unless token

    FetchEmployeesService.new(token).fetch_and_store_employees
  end
end
