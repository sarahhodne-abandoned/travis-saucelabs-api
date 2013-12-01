module Travis
  module SaucelabsAPI
    class VirtualMachine
      attr_reader :instance_id

      def initialize(instance_id, data, connection)
        @instance_id = instance_id
        @data = data
        @connection = connection
      end

      def reload
        @data = @connection.instance_info(instance_id)
      end

      def destroy
        @data = @connection.kill_instance(instance_id)
      end

      def ip_address
        @data['private_ip']
      end

      def custom_identifier
        extra_info.fetch('custom_identifier', nil)
      end

      private

      def extra_info
        @data.fetch('extra_info', {})
      end
    end
  end
end