class FetchEmployeesService
  include HTTParty
  base_uri ENV['API_BASE_URI']

  def initialize(token)
    @token = token
  end

  def fetch_and_store_employees
    response = self.class.get('/employee/list', headers: { 'Authorization' => "Bearer #{@token}" })

    if response.success?
      employees_data = JSON.parse(response.body)

      employees_data.each do |employee_data|
        # Find or create the employee by their external API ID
        employee = Employee.find_or_initialize_by(external_id: employee_data['id'])
        employee.update(
          first_name: employee_data['first_name'],
          last_name: employee_data['last_name'],
          email: employee_data['email'],
          date_of_birth: employee_data['date_of_birth'],
          address: employee_data['address'],
          country: employee_data['country'],
          bio: employee_data['bio'],
          rating: employee_data['rating']
        )
      end
    else
      Rails.logger.error("Failed to fetch employees: #{response.body}")
    end
  end
end
