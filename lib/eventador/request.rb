require "koala"

class Request
  def self.fetch(id, access_token: nil)
    unless access_token
      raise ArgumentError, "The access_token keyword argument must be provided"
    end

    client = Koala::Facebook::API.new(access_token)
    client.get_connection(id, :events)
  end
end
