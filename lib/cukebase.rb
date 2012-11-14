require "httparty"
require "active_model"
require "active_attr"
require "cukebase/version"
require "cukebase/config"
require "cukebase/request"
require "cukebase/project"
require "cukebase/ticketing_category"
require "cukebase/ticketing_status"
require "cukebase/ticket"

module Cukebase
  def self.current_project
    @current_project ||= Project.new Cukebase.config.project
  end
end

if defined? Cucumber
  Around do |scenario, block|
    ticket_name = "#{scenario.title} (#{scenario.feature.title})"
    project = Cukebase.current_project
    ticket = project.ticket_for_name ticket_name

    block.call

    ticket.status_id = case scenario.status
                       when :undefined
                         project.undefined_status
                       when :pending
                         project.pending_status
                       when :passed
                         project.passed_status
                       when :failed
                         project.failed_status
                       else
                         project.invalid_status
                       end

    # We want empty features to be undefined instead of completed (which is
    # what Cucumber tells us)
    ticket.status_id = project.undefined_status if scenario.raw_steps.empty?

    ticket.save
  end
end
