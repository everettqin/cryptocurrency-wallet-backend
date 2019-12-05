module Request
  module JsonHelpers

    def json_response
      @json ||= JSON.parse(response_body, symbolize_names: true)
    end

    def json_data
      json_response[:data]
    end

    def json_errors
      json_response[:errors]
    end

    def json_meta
      json_response[:meta]
    end

  end
end


RSpec.configure do |config|
  config.include Request::JsonHelpers, type: :acceptance
end
