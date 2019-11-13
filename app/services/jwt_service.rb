class JwtService

  def self.encode(payload, jwt=JWT)
    jwt.encode(payload, Rails.application.secrets.secret_key_base, 'HS256')
  end

  def self.decode(token, jwt=JWT)
    body, = jwt.decode(token,
                       Rails.application.secrets.secret_key_base,
                       true,
                       algorithm: 'HS256')
    HashWithIndifferentAccess.new(body) ## allows access to the hash values with either symbol or string
  rescue JWT::ExpiredSignature
    nil
  end

end