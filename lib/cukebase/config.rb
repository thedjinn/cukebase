module Cukebase
  class Config
    attr_accessor :host
    attr_accessor :protocol

    attr_accessor :username
    attr_accessor :api_key

    attr_accessor :project
    attr_accessor :category

    attr_accessor :normal_type
    attr_accessor :regression_type

    attr_accessor :undefined_status
    attr_accessor :pending_status
    attr_accessor :failed_status
    attr_accessor :passed_status
    attr_accessor :invalid_status

    def initialize
      @host = "api3.codebasehq.com"
      @protocol = "https"

      @category = "Cucumber"

      @normal_type = "Feature"
      @regression_type = "Regression"

      @undefined_status = "Open (undefined steps)"
      @pending_status = "Open (pending steps)"
      @failed_status = "Open (failing steps)"
      @passed_status = "Completed"
      @invalid_status = "Invalid"
    end
  end

  def self.config
    @config ||= Config.new
    yield @config if block_given?
    @config
  end
end
