module HttpRouter
  module Serializator
    class SSL

      def initialize(certificate)
        @certificate = certificate
      end

      def serialize
        hash = {
          'key' => @certificate.key,
          'certificate' => @certificate.certificate,
          'hostnames' => @certificate.hostnames
        }
        hash['ca_certificates'] = @certificate.ca_certificates if @certificate.ca_certificates

        hash
      end
    end
  end
end
