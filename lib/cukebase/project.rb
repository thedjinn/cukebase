module Cukebase
  class Project
    attr_reader :undefined_status
    attr_reader :pending_status
    attr_reader :failed_status
    attr_reader :passed_status
    attr_reader :invalid_status

    def initialize name
      @name = name

      @category = ticketing_category_id_for_name Cukebase.config.category

      @undefined_status = ticketing_status_id_for_name Cukebase.config.undefined_status
      @pending_status = ticketing_status_id_for_name Cukebase.config.pending_status
      @failed_status = ticketing_status_id_for_name Cukebase.config.failed_status
      @passed_status = ticketing_status_id_for_name Cukebase.config.passed_status
      @invalid_status = ticketing_status_id_for_name Cukebase.config.invalid_status
    end

    def ticketing_categories
      @ticketing_categories ||= Request.get("#{@name}/tickets/categories").parsed_response["ticketing_categories"].map do |hash|
        TicketingCategory.new hash
      end
    end

    def ticketing_statuses
      @ticketing_statuses ||= Request.get("#{@name}/tickets/statuses").parsed_response["ticketing_statuses"].map do |hash|
        TicketingStatus.new hash
      end
    end

    def ticket_for_name name
      data = Request.get("#{@name}/tickets", query: { query: "subject:\"#{name}\" category:\"#{Cukebase.config.category}\"" }).parsed_response["tickets"].first

      if data
        Ticket.new data
      else
        Ticket.new summary: name, category_id: @category, ticket_type: Cukebase.config.normal_type
      end
    end

    def ticketing_category_id_for_name name
      ticketing_categories.find do |ticketing_category|
        ticketing_category.name == name
      end.try(:id) or raise "Could not find a Codebase ticket category with name \"#{name}\". Please create it first."
    end

    def ticketing_status_id_for_name name
      ticketing_statuses.find do |ticketing_status|
        ticketing_status.name == name
      end.try(:id) or raise "Could not find a Codebase ticket status with name \"#{name}\". Please create it first."
    end
  end
end
