class ApiAuthenticationService
  include HTTParty
  base_uri ENV['API_BASE_URI']

  def initialize
    @client_id = ENV['API_CLIENT_ID']
    @client_secret = ENV['API_CLIENT_SECRET']
    @username = ENV['API_USERNAME']
    @password = ENV['API_PASSWORD']
  end

  def authenticate
    response = self.class.post('/token', {
      body: {
        grant_type: 'password',
        client_id: @client_id,
        client_secret: @client_secret,
        username: @username,
        password: @password
      }.to_json,
      headers: { 'Content-Type' => 'application/json' }
    })

    return JSON.parse(response.body)['access_token'] if response.success?
  end
end
