module Cukebase
  class Ticket
    include ActiveAttr::Model

    attribute :ticket_id
    attribute :summary
    attribute :ticket_type
    attribute :reporter_id
    attribute :assignee_id
    attribute :assignee
    attribute :reporter
    attribute :category_id
    attribute :category
    attribute :priority_id
    attribute :priority
    attribute :status_id
    attribute :status
    attribute :milestone_id
    attribute :milestone
    attribute :deadline
    attribute :tags
    attribute :estimated_time
    attribute :project_id

    attribute :created_at
    attribute :updated_at

    def self.wrap_setter name
      define_method "#{name}=" do |value|
        @changes[name] = value if @changes && value != send(name)
        super value
      end
    end

    def initialize *args, &block
      super

      @changes = {}
    end

    wrap_setter :status_id
    wrap_setter :priority_id
    wrap_setter :category_id
    wrap_setter :assignee_id
    wrap_setter :milestone_id
    wrap_setter :summary
    wrap_setter :tags

    def update_ticket content
      data = {}

      data[:changes] = @changes if @changes.any?
      data[:content] = content if content && self.content != content

      if data.any?
        Request.post "#{Cukebase.config.project}/tickets/#{ticket_id}/notes", body: data.to_xml(root: "ticket-note", skip_types: true, skip_instruct: true)
      end
    end

    def create_ticket content
      data = {}
      data[:summary] = summary if summary?
      data[:description] = content if content
      data[:ticket_type] = ticket_type if ticket_type?
      data[:category_id] = category_id if category_id?
      data[:priority_id] = priority_id if priority_id?
      data[:status_id] = status_id if status_id?
      data[:assignee_id] = assignee_id if assignee_id?
      data[:milestone_id] = milestone_id if milestone_id?

      Request.post "#{Cukebase.config.project}/tickets", body: data.to_xml(root: "ticket", skip_types: true, skip_instruct: true)
    end

    def save content=nil
      if ticket_id?
        update_ticket content
      else
        create_ticket content
      end
    end
  end
end
