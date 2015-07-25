module HttpRouter
  # Application class
  #
  class Application
    attr_reader :hostnames, :name

    def initialize(name)
      @name = name.to_s
      @hostnames = []
    end

    def add_hostname(hostname)
      @hostnames.push(hostname) unless @hostnames.include?(hostname)
    end
  end
end
