module HttpRouter
  # Application class
  #
  class Application
    attr_reader :name, :ssl_required, :hostnames

    def initialize(name)
      @name = name.to_s
      @hostnames = []
    end

    def ssl_required=(value)
      @ssl_required = value === true
    end

    def add_hostname(hostname)
      @hostnames.push(hostname) unless @hostnames.include?(hostname)
    end
  end
end
