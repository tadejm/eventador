require "eventador/event"

module Eventador
  module_function

  def get_events(page_id)
    Request.fetch(page_id).map { |event_attrs|
      Event.new(event_attrs)
    }
  end
end
