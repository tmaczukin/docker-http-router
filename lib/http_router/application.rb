module HttpRouter
  # Application class
  #
  class Application
    attr_reader :hostnames

    def initialize
      @hostnames = []
    end

    def add_hostname(hostname)
      @hostnames.push(hostname) unless @hostnames.include?(hostname)
    end
  end
end
