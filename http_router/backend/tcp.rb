require 'resolv'

module HttpRouter
  module Backend
    class TCP
      attr_reader :ip, :port

      def initialize(ip, port)
        raise ArgumentError, "Invalid IP address: #{ip}" unless ip.match(Resolv::IPv4::Regex)
        raise ArgumentError, "Invalid port: #{port}" unless port >= 1 && port <= 65535

        @ip = ip
        @port = port
      end

      def link
        "#{@ip}:#{@port}"
      end
    end
  end
end
