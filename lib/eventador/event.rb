module Eventador
  class Event
    attr_reader :attributes

    def initialize(attrs)
      @attributes = attrs
    end

    def name
      attributes["name"]
    end

    def date
      Date.parse(attributes["start_time"])
    end

    def description
      attributes["description"]
    end

    def time
      return unless has_time?
      Time.parse(attributes["start_time"])
    end

    def has_time?
      !attributes["is_date_only"]
    end
  end
end
