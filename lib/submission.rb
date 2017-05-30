module Submission
    def create_submission(checkpoint_id, assignment_branch, assignment_commit_link, comment, update_id = nil)
        enrollment_id = self.get_enrollment_id
        
        headers = {
            "Content-Type" => "application/json",
            "authorization" => @auth_token
        }
        
        body = {
            "checkpoint_id" => checkpoint_id,
            "assignment_branch" => assignment_branch,
            "assignment_commit_link" => assignment_commit_link,
            "comment" => comment,
            "enrollment_id" => enrollment_id
        }
        
        url = "/checkpoint_submissions"
        
        if update_id
            url = "#{url}/#{update_id}"
        end

        @response = self.class.post(url, headers: headers, body: body.to_json)
    end
end