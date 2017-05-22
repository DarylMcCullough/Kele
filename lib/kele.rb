class Kele
    require 'httparty'
    include HTTParty
    attr_reader :auth_token
    
    base_uri "https://www.bloc.io/api/v1"
    
    def initialize(email, password)
        @email = email
        @password = password
        body = { email: @email, password: @password }
        response = self.class.post("/sessions", body: body)
        @auth_token = response["auth_token"]
    end
end
        