class Kele
    require 'httparty'
    require 'json'
    require_relative 'roadmap'
    require_relative 'messages'
    require_relative 'submission'
    
    include HTTParty
    include Roadmap
    include Messages
    include Submission
    
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

        @response = self.class.post("/sessions", 
            :body => body.to_json, # since the Content-Type is json
            :headers => headers )
        @auth_token = @response["auth_token"]
        @my_info = nil
    end
    
    def get_me(refetch=false) # get information about user. If refetch=false, then use stored information, if already fetched
        if !refetch && @my_info
            return @my_info
        end
        headers = { 
            "Content-Type" => "application/json",
            "authorization" => @auth_token
        }
        @response = self.class.get("/users/me", headers: headers)
        body_text = response.body
        
        @my_info = JSON.parse(body_text) #save information for later
    end
    
    def get_mentor_id # convenience method
        get_me["current_enrollment"]["mentor_id"]
    end
    
    def get_roadmap_id # convenience method
        get_me["current_enrollment"]["roadmap_id"]
    end
    
    def get_mentor_availability(id = get_mentor_id) # return mentor availability for given mentor id. The default is the mentor id of the user
        headers = { 
            "Content-Type" => "application/json",
            "authorization" => @auth_token
        }
        @response = self.class.get("/mentors/#{id}/student_availability", headers: headers)
        body_text = response.body
        JSON.parse(body_text)
    end
    
    def get_enrollment_id
        get_me["current_enrollment"]["id"]
    end
    
    
end
