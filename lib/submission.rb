module Submission
    def create_submission(checkpoint_id, assignment_branch, assignment_commit_link, comment)
        enrollment_id = self.get_enrollment_id
        
        headers = {
            "Content-Type" => "application/json",
            "authorization" => @auth_token
        }
        
        body = {
            "checkpoint_id" => checkpoint_id,
            "assignment_branch" => assignment_branch,
            "assignment_commit_link" => assignment_commitment_link,
            "comment" => comment,
            "enrollment_id" => enrollment_id
        }

        response = self.class.post("/messages", headers: headers, body: body.to_json)
    end
end