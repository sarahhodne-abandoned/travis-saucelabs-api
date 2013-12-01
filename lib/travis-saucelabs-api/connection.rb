require 'faraday'
require 'faraday_middleware'

module Travis
  module SaucelabsAPI
    class Connection
      DEFAULT_IMAGE = 'ichef-travis-osx8-latest'

      def initialize(uri)
        @connection = Faraday.new(uri) do |connection|
          connection.use FaradayMiddleware::EncodeJson
          connection.use FaradayMiddleware::ParseJson, content_type: /\bjson$/
          connection.adapter Faraday.default_adapter
        end
      end

      def capacity
        get('/capacity')
      end

      def start_instance(startup_info=nil, image=DEFAULT_IMAGE)
        post('/instances', startup_info, image: image)
      end

      def list_instances
        get('/instances')
      end

      def instance_info(instance_id)
        get("/instances/#{uri_escape(instance_id)}")
      end

      def kill_instance(instance_id)
        instance_id = uri_escape(instance_id)
        delete("/instances/#{instance_id}")
      end

      def allow_outgoing(instance_id)
        instance_id = uri_escape(instance_id)
        post("/instances/#{instance_id}/allow_outgoing")
      end

      def allow_incoming(instance_id, cidr, port)
        instance_id = uri_escape(instance_id)
        post("/instances/#{instance_id}/allow_incoming", nil, cidr: cidr, port: port)
      end

      def save_image(instance_id, name)
        instance_id = uri_escape(instance_id)
        post("/instances/#{instance_id}/save_image", nil, name: name)
      end

      private

      def get(path)
        handle_response(@connection.get(path))
      end

      def post(path, body=nil, params=nil)
        response = @connection.post(path, body) do |request|
          request.params.update(params) if params
        end

        handle_response(response)
      end

      def delete(path)
        handle_response(@connection.delete(path))
      end

      def handle_response(response)
        if response.status == 404
          nil
        else
          response.body
        end
      end

      def uri_escape(str)
        Faraday::Utils.escape(str)
      end
    end
  end
end
