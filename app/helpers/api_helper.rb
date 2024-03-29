module ApiHelper
  class JsonWebToken
    SECRET_KEY = Rails.application.secrets.secret_key_base.to_s
    def self.encode(payload)
      JWT.encode(payload, SECRET_KEY, 'HS256')
    end

    def self.decode(token)
      JWT.decode token, SECRET_KEY, true, { algorithm: 'HS256' }
    end
  end
end
