require 'test_helper'

class ApiAuthenticationServiceTest < ActiveSupport::TestCase
  def setup
    @service = ApiAuthenticationService.new
  end

  test "authenticates successfully and returns the access token" do
    # Mock the API response
    response_body = { access_token: "mocked_token" }.to_json
    stub_request(:post, "#{ENV['API_BASE_URI']}/token")
      .to_return(status: 200, body: response_body, headers: { 'Content-Type' => 'application/json' })

    # Call the service
    token = @service.authenticate

    # Assertions
    assert_equal "mocked_token", token
  end

  test "returns nil if authentication fails" do
    # Mock a failed response
    stub_request(:post, "#{ENV['API_BASE_URI']}/token")
      .to_return(status: 401, body: "", headers: { 'Content-Type' => 'application/json' })

    # Call the service
    token = @service.authenticate

    # Assertions
    assert_nil token
  end
end
