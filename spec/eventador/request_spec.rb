require "vcr"

VCR.configure do |c|
  c.cassette_library_dir = "spec/cassettes"
  c.hook_into :faraday
end

require_relative "../../lib/eventador/request"

module Eventador
  describe Request do
    let(:fb_object_id) { "Ladjica" }
    let(:access_token) { "186380458197207|AsLPUwNdobrdrpmuG_JUG2ZsM54" }

    it "fetches events for a given object" do
      VCR.use_cassette "request" do
        result = Request.fetch fb_object_id, access_token: access_token
        expect(result).to eq([{"name"=>"Tralala",
                               "start_time"=>"2013-08-23",
                               "location"=>"Rečni transport Ladjica",
                               "id"=>"209214662535456"
                               },
                               {"name"=>"Test",
                               "start_time"=>"2013-08-21T19:00:00+0200",
                               "timezone"=>"Europe/Ljubljana",
                               "location"=>"Rečni transport Ladjica",
                               "id"=>"500370866714288"}])
      end
    end

    it "raises an ArgumentError if access_token is not provided" do
      expect {
        Request.fetch fb_object_id, access_token: nil
      }.to raise_exception(ArgumentError, /access_token/)
    end

  end
end
