class CachedFetchEmployeesService
  def initialize
    @authentication_service = ApiAuthenticationService.new
  end

  def fetch_employees
    Rails.cache.fetch('employees', expires_in: 10.minutes) do
      token = @authentication_service.authenticate
      return [] unless token

      FetchEmployeesService.new(token).fetch_employees
    end
  end
end
