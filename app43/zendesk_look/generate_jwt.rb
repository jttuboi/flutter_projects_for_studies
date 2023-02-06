require 'jwt'

payload = {:scope => 'user', :external_id => CPF,:email => EMAIL, :name => NAME}
jwtHeader = {:kid => ID}

token = JWT.encode payload, SECRET, 'HS256', jwtHeader
puts token