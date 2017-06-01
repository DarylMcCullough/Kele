module Messages
    def get_messages(page_num = 1) # return message threads from the given page
        get_single_page(page_num)
    end
    
    def get_number_of_pages # convenience method, returns number of pages for all messages
        count = get_single_page["count"]
        (count + 9)/10
    end
    
    def get_all_message_threads # convenience method, fetches all message threads
        num_pages = get_number_of_pages
        (1..num_pages).each do |page|
            threads = combine(threads, get_single_page(page))
        end
        return threads
    end
    
    def get_single_page(page_num) # gets a single page
        headers = {
            "Content-Type" => "application/json",
            "authorization" => @auth_token
        }
        body = {
            "page" => page_num.to_s
        }
        
        @response = self.class.get("/message_threads", headers: headers, body: body.to_json)
        body_text = response.body
        JSON.parse(body_text)
    end
    
    def create_message(recipient_id, subject, text, token = nil) # posts a new message to the thread specified by the token (or a new thread if token is nil)
        headers = {
            "Content-Type" => "application/json",
            "authorization" => @auth_token
        }
        
        body = {
            "sender" => @email,
            "recipient_id" => recipient_id,
            "subject" => subject,
            "stripped-text" => text
        }
        if token
            body["token"] = token
        end
        @response = self.class.post("/messages", headers: headers, body: body.to_json)
    end

    private
    
    def combine(threads1, threads2) # puts two message thread responses together
        puts "threads1['items'].length: #{threads1['items'].length}"
        puts "threads2['items'].length: #{threads2['items'].length}"

        items = threads1["items"] + threads2["items"]
        count = threads1["count"]
        threads =  {"items" => items, "count" => count}
        puts "threads['items'].length: #{threads['items'].length}"
        threads
    end
end