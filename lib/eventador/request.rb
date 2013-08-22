require "koala"

class Request
  def self.fetch_events(id, access_token: nil)
    new(access_token).fetch(id)
  end

  attr_reader :client

  def initialize(access_token)
    @client = init_client(access_token)
  end

  def fetch(object_id)
    fetch_events(object_id).map { |event_attrs|
      fetch_event(event_attrs["id"])
    }
  end

  def fetch_events(object_id)
    client.get_connection(object_id, :events)
  end

  def fetch_event(event_id)
    client.get_object(event_id)
  end

  private

  def init_client(access_token)
    unless access_token
      raise ArgumentError, "The access_token keyword argument must be provided"
    end
    Koala::Facebook::API.new(access_token)
  end
end
