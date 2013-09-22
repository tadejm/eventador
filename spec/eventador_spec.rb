require "spec_helper"
require "eventador"

describe Eventador do
  let(:access_token) { "186380458197207|AsLPUwNdobrdrpmuG_JUG2ZsM54" }
  let(:event) {
    VCR.use_cassette "eventador" do
      Eventador.get_events("Ladjica", access_token)[0]
    end
  }

  describe "first event" do
    it "returns its name" do
      expect(event.name).to eq("Open party")
    end

    it "returns its date" do
      expect(event.date).to eq(Date.new(2013, 9, 22))
    end

    it "returns its description" do
      expect(event.description).to eq("Opening party ")
    end

    it "returns its time" do
      expect(event.time).to eq(Time.new(2013, 9, 22, 21, 55))
    end
  end

end
