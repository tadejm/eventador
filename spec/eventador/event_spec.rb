require_relative "../../lib/eventador/event"

module Eventador
  describe Event do
    it "returns its name" do
      event = Event.new "name" => "Tralala"
      expect(event.name).to eq("Tralala")
    end

    it "returns its date" do
      event = Event.new "start_time" => "2013-08-23"
      expect(event.date).to eq(Date.new(2013, 8, 23))
    end

    it "returns its description" do
      event = Event.new "description" => "Hopsasas"
      expect(event.description).to eq("Hopsasas")
    end

    it "returns its time" do
      event = Event.new "start_time" => "2013-08-21T19:00:00+0200",
        "is_date_only" => false
      expect(event.time).to eq(Time.new(2013, 8, 21, 19))
    end

    it "returns nil when event has no time" do
      event = Event.new "is_date_only" => true
      expect(event.time).to eq(nil)
    end
  end
end
