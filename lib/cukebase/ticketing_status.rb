module Cukebase
  class TicketingStatus
    include ActiveAttr::Model

    attribute :id
    attribute :name
    attribute :background_colour
    attribute :order
    attribute :treat_as_closed
  end
end
