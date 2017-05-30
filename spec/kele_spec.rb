require "spec_helper"

describe Kele, type: :request do
  describe '#initialize' do
    it 'authenticates the user', vcr: {cassette_name: :initialize} do
      kele = Kele.new(ENV['EMAIL'], ENV['PASSWORD'])
      expect(kele.instance_variable_get(:@auth_token)).to be_a String
    end
  end

   describe '#get_me' do
     it 'gets my info', vcr: {cassette_name: :get_me} do
       kele = Kele.new(ENV['EMAIL'], ENV['PASSWORD'])
       response = kele.get_me
       expect(response).to be_a Hash
     end
   end

   describe '#get_mentor_availability' do
     it 'gets mentor availability', vcr: {cassette_name: :get_mentor_availability} do
       kele = Kele.new(ENV['EMAIL'], ENV['PASSWORD'])
       response = kele.get_mentor_availability
       expect(response).to be_a Array
     end
   end

   describe '#get_messages' do
     it 'gets messages', vcr: {cassette_name: :get_messages} do
       kele = Kele.new(ENV['EMAIL'], ENV['PASSWORD'])
       response = kele.get_messages
       expect(response).to be_a Hash
       expect(response["items"]).to be_a Array
     end
   end

   describe '#get_roadmap' do
     it 'gets roadmap', vcr: {cassette_name: :get_roadmap} do
       kele = Kele.new(ENV['EMAIL'], ENV['PASSWORD'])
       response = kele.get_roadmap
       expect(response).to be_a Hash
       expect(response['sections']).to be_a Array
     end
   end

   describe '#get_checkpoint' do
     it 'gets checkpoint info', vcr: {cassette_name: :get_checkpoint} do
       kele = Kele.new(ENV['EMAIL'], ENV['PASSWORD'])
       response = kele.get_checkpoint(ENV['CHECKPOINT_ID'])
       expect(response).to be_a Hash
     end
   end

   describe '#create_message' do
     it 'creates message', vcr: {cassette_name: :create_message} do
       kele = Kele.new(ENV['EMAIL'], ENV['PASSWORD'])
       mentor_id = kele.get_mentor_id
       response = kele.create_message(mentor_id, "Testing kele","test text")
       puts response.class
       expect(response.code).to eq(200)
     end
   end

   describe '#create_submission' do
     it 'creates submission', vcr: {cassette_name: :create_submission} do
       kele = Kele.new(ENV['EMAIL'], ENV['PASSWORD'])
       response = kele.create_submission(ENV['CHECKPOINT_ID'], ENV['ASSIGNMENT_BRANCH'], ENV['COMMIT_URL'], ENV['SUBMISSION_COMMENT'])
       puts response.class
       expect(response.code).to eq(200)
     end
   end
   
   describe '#create_submission_update' do
     it 'updates submission', vcr: {cassette_name: :update_submission} do
       kele = Kele.new(ENV['EMAIL'], ENV['PASSWORD'])
       response = kele.create_submission(ENV['CHECKPOINT_ID'], ENV['ASSIGNMENT_BRANCH'], ENV['COMMIT_URL'], ENV['UPDATE_COMMENT'], ENV["SUBMISSION_ID"])
       puts response.class
       expect(response.code).to eq(200)
     end
   end

end