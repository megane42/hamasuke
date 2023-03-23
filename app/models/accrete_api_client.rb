class AccreteApiClient
  ACCRETE_API_BASE_URL = "https://api.acrt.jp".freeze

  PushError = Class.new(StandardError)

  def initialize
    @accrete_api_account_id = ENV["ACCRETE_API_ACCOUNT_ID"]
    @accrete_api_request_id = ENV["ACCRETE_API_REQUEST_ID"]
    @accrete_api_password   = ENV["ACCRETE_API_PASSWORD"]
    @conn = Faraday.new(url: ACCRETE_API_BASE_URL) do |faraday|
      faraday.adapter Faraday.default_adapter
      faraday.response :json
    end
  end

  def send_short_message(text:, telno:)
    res = @conn.post("/ibss/api/sms_reg/#{accrete_api_account_id}/json") do |req|
      req.headers["Content-Type"] = "application/x-www-form-urlencoded"
      req.params["id"]          = accrete_api_request_id
      req.params["pass"]        = accrete_api_password
      req.params["text.long"]   = text
      req.params["telno"]       = telno
      req.params["shorten_url"] = "secure"
    end
    { http_status: res.status, response_body: res.body }
  end

  def send_short_message!(text:, telno:)
    response = send_short_message(text: text, telno: telno)
    if response[:http_status] != 200
      raise PushError.new("Failed to exec #{self.class.name} (status: #{response[:http_status]}, body: #{response[:response_body]})")
    end
    response
  end

  private
    attr_reader :accrete_api_account_id
    attr_reader :accrete_api_request_id
    attr_reader :accrete_api_password
end
