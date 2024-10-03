class EmployeesController < ApplicationController
  include Pagy::Backend

  def index
    employees = Employee.where("(first_name || ' ' || last_name) LIKE :search OR email LIKE :search OR date_of_birth LIKE :search", search: "%#{params[:search]}%").by_recently_created

    @pagy, @employees = pagy(employees, items: 10)
  end
end
