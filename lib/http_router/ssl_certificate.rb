module HttpRouter
  class SSLCertificate
    attr_reader   :key, :certificate, :hostnames
    attr_accessor :ca_certificates

    def initialize(key, certificate, hostnames)
      raise ArgumentError, "Array of hostnames expected" unless hostnames.kind_of?(Array)

      @key = key
      @certificate = certificate
      @hostnames = hostnames
    end
  end
end
