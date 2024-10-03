class EmployeesController < ApplicationController
  def index
    @employees = Employee.where("(first_name || ' ' || last_name) LIKE :search OR email LIKE :search OR date_of_birth LIKE :search", search: "%#{params[:search]}%").all
  end
end
