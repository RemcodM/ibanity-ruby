module Ibanity
  module IsabelConnect
    class RefreshToken < Ibanity::OAuthResource
      class << self
        warn "WARNING: Ibanity::IsabelConnect::RefreshToken is deprecated, please use Ibanity::IsabelConnect::Token instead"
      end

      def self.create(authorization_code:, redirect_uri:, idempotency_key: nil)
        uri = Ibanity.isabel_connect_api_schema["oAuth2"]["refreshTokens"]["create"]
        arguments = [
          ["grant_type", "authorization_code"],
          ["code", authorization_code],
          ["client_id", Ibanity.client.isabel_connect_client_id],
          ["client_secret", Ibanity.client.isabel_connect_client_secret],
          ["redirect_uri", redirect_uri]
        ]
        payload = URI.encode_www_form(arguments)
        create_by_uri(uri: uri, payload: payload, idempotency_key: idempotency_key)
      end

      def self.delete(token:)
        uri = Ibanity.isabel_connect_api_schema["oAuth2"]["refreshTokens"]["revoke"]
        arguments = [
          ["token", token],
          ["client_id", Ibanity.client.isabel_connect_client_id],
          ["client_secret", Ibanity.client.isabel_connect_client_secret]
        ]
        payload = URI.encode_www_form(arguments)
        create_by_uri(uri: uri, payload: payload)
      end
    end
  end
end
