# frozen_string_literal: true

class JwtService
  def self.encode(payload)
    JWT.encode(payload, ENV['SECRET_KEY_BASE'], 'HS256')
  end

  def self.decode(token)
    body, = JWT.decode(token, ENV['SECRET_KEY_BASE'],
                       true, algorithm: 'HS256')
    HashWithIndifferentAccess.new(body)
  rescue JWT::ExpiredSignature
    nil
  end
end
