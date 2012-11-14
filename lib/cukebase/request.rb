module Cukebase
  class Request
    include HTTParty

    format :xml
    headers 'Accept' => 'application/xml'
    headers 'Content-type' => 'application/xml'

    [:get, :post, :put, :delete].each do |method_name|
      define_singleton_method method_name do |url, *args, &block|
        basic_auth Cukebase.config.username, Cukebase.config.api_key
        super "#{Cukebase.config.protocol}://#{Cukebase.config.host}/#{url}", *args, &block
      end
    end
  end
end
