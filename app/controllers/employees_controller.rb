class EmployeesController < ApplicationController
  def index
    @employees = Employee.all.sort_by(&:created_at)
  end
end
