require "eventador/event"
require "eventador/request"

module Eventador
  module_function

  def get_events(page_id, access_token)
    Request.fetch_events(page_id, access_token: access_token).map { |event_attrs|
      Event.new(event_attrs)
    }
  end
end
