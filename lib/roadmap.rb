module Roadmap
    def get_roadmap(id = get_roadmap_id, refetch=false) # return roadmap for given roadmap id. default is the current roadmap of the user
        if !refetch && id == get_roadmap_id && @my_roadmap
            return @my_roadmap
        end
        headers = {
            "Content-Type" => "application/json",
            "authorization" => @auth_token
        }
        @response = self.class.get("/roadmaps/#{id}", headers: headers)
        body_text = response.body
        @roadmap = JSON.parse(body_text)
    end

    def display_checkpoints(id = get_roadmap_id) # Lists all checkpoints, their name, id and section
        roadmap = get_roadmap(id)
        sections = roadmap["sections"]
        sections.each do |section|
            puts "Section: #{section['name']}"
            section["checkpoints"].each do |cp|
                puts "    Checkpoint #{cp['id']}: #{cp['name']}"
            end
        end
        nil
    end
    
    def get_checkpoint(id) # return checkpoint for given checkpoint id.

        headers = {
            "Content-Type" => "application/json",
            "authorization" => @auth_token
        }
        @response = self.class.get("/checkpoints/#{id}", headers: headers)
        body_text = response.body
        JSON.parse(body_text)
    end

end