module HttpRouter
  # Application class
  #
  class Application
    attr_reader   :name, :ssl_required, :hostnames, :backends, :ssl_certificates
    attr_accessor :error_page

    def initialize(name)
      @name = name.to_s
      @ssl_required = false
      @hostnames = []
      @backends = []
      @ssl_certificates = []
    end

    def ssl_required=(value)
      @ssl_required = value === true
    end

    def add_hostname(hostname)
      @hostnames.push(hostname) unless @hostnames.include?(hostname)
    end

    def add_backend(backend)
      @backends.push(backend) unless @backends.include?(backend)
    end

    def add_ssl_certificate(ssl_certificate)
      @ssl_certificates.push(ssl_certificate) unless @ssl_certificates.include?(ssl_certificate)

      ssl_certificate.hostnames.each do |hostname|
        add_hostname(hostname)
      end
    end
  end
end
