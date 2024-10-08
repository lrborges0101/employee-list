require 'test_helper'

class FetchEmployeesServiceTest < ActiveSupport::TestCase
  def setup
    @service = FetchEmployeesService.new("mocked_token")
  end

  test "fetches employees and stores them in the database" do
    # Mock the API response
    response_body = [
      { id: 1, first_name: "John", last_name: "Doe", email: "john@example.com", date_of_birth: "1990-01-01", address: "123 Main St", country: "USA", bio: "Engineer", rating: 5 }
    ].to_json
    stub_request(:get, "#{ENV['API_BASE_URI']}/employee/list")
      .with(headers: { 'Authorization' => 'Bearer mocked_token' })
      .to_return(status: 200, body: response_body, headers: { 'Content-Type' => 'application/json' })

    # Call the service
    @service.fetch_and_store_employees

    # Assertions: check that the employee is saved in the database
    employee = Employee.find_by(external_id: 1)
    assert_not_nil employee
    assert_equal "John", employee.first_name
    assert_equal "Doe", employee.last_name
    assert_equal "john@example.com", employee.email
  end

  test "logs an error when the API request fails" do
    # Mock a failed API response
    stub_request(:get, "#{ENV['API_BASE_URI']}/employee/list")
      .to_return(status: 500, body: "Internal Server Error")

    # Mock the logger
    Rails.logger.expects(:error).with("Failed to fetch employees: Internal Server Error")

    # Call the service
    @service.fetch_and_store_employees
  end
end
