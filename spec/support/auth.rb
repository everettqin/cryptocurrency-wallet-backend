require 'devise'

module Requests
  module AuthHelpers
    module Extensions

    end

    module Includables
      def sign_in(user)
        auth_token_headers = self.public_send(user).create_new_auth_token
        auth_token_headers.map {|k, v| header k, v}
      end
    end
  end
end

RSpec.configure do |config|

  config.include Requests::AuthHelpers::Includables, type: :acceptance
  config.extend Requests::AuthHelpers::Extensions, type: :acceptance
end