class Kele
    require 'httparty'
    require 'json'
    
    include HTTParty
    attr_reader :auth_token, :response
    
    base_uri "https://www.bloc.io/api/v1"
    
    def initialize(email, password)
        @email = email
        @password = password
        body = { email: @email, password: @password }
        
        headers = {
            'Content-Type' => 'application/json', 
            'Accept' => 'application/json'
        }

        response = self.class.post("/sessions", 
            :body => body.to_json,
            :headers => headers )
        @response = response
        @auth_token = response["auth_token"]
    end
    
    def get_me
        headers = { 
            "Content-Type" => "application/json",
            "authorization" => @auth_token
        }
        response = self.class.get("/users/me", headers: headers)
        body_text = response.body
        JSON.parse(body_text)
    end

end
