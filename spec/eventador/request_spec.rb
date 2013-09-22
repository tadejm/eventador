require "spec_helper"
require_relative "../../lib/eventador/request"

module Eventador
  describe Request do
    let(:fb_object_id) { "Ladjica" }
    let(:fb_event_id)  { "209214662535456" }
    let(:access_token) { "186380458197207|AsLPUwNdobrdrpmuG_JUG2ZsM54" }

    it "returns hashes of event info for a given facebook object id" do
      VCR.use_cassette "fetch" do
        result = Request.fetch_events(fb_object_id, access_token: access_token)

        expect(result[0]["name"]).to eq("Tralala")
        expect(result[0]["start_time"]).to eq("2013-08-23")
        expect(result[0]["description"]).to eq("Hopsasas")
        expect(result[1]["name"]).to eq("Test")
        expect(result[1]["start_time"]).to eq("2013-08-21T19:00:00+0200")
        expect(result[1]["description"]).to eq("very much")
      end
    end

    it "fetches events for a given object" do
      VCR.use_cassette "fetch_events" do
        result = Request.new(access_token).fetch_events(fb_object_id)
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

    it "fetches details for given event id" do
      VCR.use_cassette "fetch_event" do
        result = Request.new(access_token).fetch_event(fb_event_id)
        expect(result).to eq(
          "id"=>"209214662535456",
          "owner"=>{"category"=>"Transportation",
            "category_list"=>[{"id"=>"163431627040738",
              "name"=>"Boat Service"}],
            "name"=>"Rečni transport Ladjica",
            "id"=>"1401826506698650"},
            "name"=>"Tralala",
            "description"=>"Hopsasas",
            "start_time"=>"2013-08-23",
            "is_date_only"=>true,
            "location"=>"Rečni transport Ladjica",
            "venue"=>{"latitude"=>46.042627666252,
              "longitude"=>14.506661271181,
              "city"=>"Ljubljana",
              "state"=>"",
              "country"=>"Slovenia",
              "id"=>"1401826506698650",
              "street"=>"Trnovski pristan 8",
              "zip"=>"1000"},
            "privacy"=>"OPEN",
            "updated_time"=>"2013-08-19T18:31:51+0000")
      end
    end

    it "raises an ArgumentError if access_token is not provided" do
      expect {
        Request.new(nil)
      }.to raise_exception(ArgumentError, /access_token/)
    end

  end
end
