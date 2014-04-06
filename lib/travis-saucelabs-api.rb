require 'travis-saucelabs-api/version'
require 'faraday'
require 'faraday_middleware'

module Travis
  class SaucelabsAPI
    class Error < StandardError; end
    class ClientError < Error; end
    class ServerError < Error; end
    class NotFoundError < ClientError; end

    DEFAULT_IMAGE = 'ichef-travis-osx8-latest'

    # Public: Initialize a new API client instance
    #
    # uri - The URI or String endpoint for the API. This should include the
    #       username and password used for authentication.
    def initialize(uri)
      @connection = Faraday.new(uri) do |connection|
        connection.use FaradayMiddleware::EncodeJson
        connection.use FaradayMiddleware::ParseJson, content_type: /\bjson$/
        connection.adapter Faraday.default_adapter
      end
    end

    def capacity
      handle_response(@connection.get('/capacity'))
    end

    def start_instance(startup_info=nil, image=DEFAULT_IMAGE)
      response = @connection.post('/instances', startup_info) do |request|
        request.params.update(image: image)
      end

      handle_response(response)
    end

    def list_instances
      handle_response(@connection.get('/instances'))
    end

    def instance_info(instance_id)
      handle_response(@connection.get("/instances/#{uri_escape(instance_id)}"))
    end

    def kill_instance(instance_id)
      instance_id = uri_escape(instance_id)
      handle_response(@connection.delete("/instances/#{instance_id}"))
    end

    def allow_outgoing(instance_id)
      instance_id = uri_escape(instance_id)
      handle_response(@connection.post("/instances/#{instance_id}/allow_outgoing"))
    end

    def allow_incoming(instance_id, cidr, port)
      instance_id = uri_escape(instance_id)
      response = @connection.post("/instances/#{instance_id}/allow_incoming") do |request|
        request.params.update(cidr: cidr, port: port)
      end

      handle_response(response)
    end

    def save_image(instance_id, name)
      instance_id = uri_escape(instance_id)
      response = @connection.post("/instances/#{instance_id}/save_image") do |request|
        request.params.update(name: name)
      end

      handle_response(response)
    end

    private

    def handle_response(response)
      case response.status
      when 404
        fail NotFoundError, response.body
      when 400...500
        fail ClientError, response.body
      when 500...600
        fail ServerError, response.body
      end

      response.body
    end

    def uri_escape(str)
      Faraday::Utils.escape(str)
    end
  end
end
