class JwtService
  ALGO = 'HS256'.freeze

  # returns token
  def encode(payload)
    raise MissingEnvVariableError, 'Jwt secret is not in env' if secret.blank?

    payload[:exp] = token_expiration
    JWT.encode(payload, secret, ALGO)
  end

  # returns payload
  def decode(token)
    begin
      payload = JWT.decode(token, secret, true, { algorithm: ALGO }).first
    rescue JWT::VerificationError
      return nil
    end
    payload
  end

  def token_expiration
    Time.now.to_i + 10800
  end

  def secret
    ENV['JWT_SECRET']
  end
end
