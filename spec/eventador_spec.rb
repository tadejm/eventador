require "eventador"

describe Eventador do
  before do
    stub_const "Request", double("Request")
    allow(Request).to receive(:fetch).with(page_id).and_return events
  end

  let(:page_id) { "12345" }
  let(:events) { [
      {
        "name"=>"Tralala",
        "start_time"=>"2013-08-23",
        "location"=>"Rečni transport Ladjica",
        "description"=>"Hopsasas",
        "is_date_only"=>true,
        "id"=>"209214662535456"
      },
      {
        "name"=>"Test",
        "start_time"=>"2013-08-21T19:00:00+0200",
        "timezone"=>"Europe/Ljubljana",
        "location"=>"Rečni transport Ladjica",
        "description"=>"Testis",
        "id"=>"500370866714288"
      }]
  }

  describe "first event" do
    let(:event) { Eventador.get_events(page_id)[0] }

    it "returns its name" do
      expect(event.name).to eq("Tralala")
    end

    it "returns its date" do
      expect(event.date).to eq(Date.new(2013, 8, 23))
    end

    it "returns its description" do
      expect(event.description).to eq("Hopsasas")
    end

    it "returns nil because it has no time" do
      expect(event.time).to eq(nil)
    end
  end

  describe "second event" do
    let(:event) { Eventador.get_events(page_id)[1] }

    it "returns its name" do
      expect(event.name).to eq("Test")
    end

    it "returns its date" do
      expect(event.date).to eq(Date.new(2013, 8, 21))
    end

    it "returns its description" do
      expect(event.description).to eq("Testis")
    end

    it "returns its time" do
      expect(event.time).to eq(Time.new(2013, 8, 21, 19))
    end
  end

end
