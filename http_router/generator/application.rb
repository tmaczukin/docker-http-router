module HttpRouter
  module Generator
    class Application

      def initialize(application)
        @application = application

        @upstream = Upstream.new(application)
        upstream_name = @upstream.name

        @default_server = DefaultServer.new(application, upstream_name)
        @ssl_redirect_server = SSLRedirectServer.new(application, upstream_name)
        @ssl_server = SSLServer.new(application, upstream_name)
      end

      def generate
        output = <<EOCONFIGURATION
#{@upstream.generate}
#{@default_server.generate}
#{@ssl_redirect_server.generate}
#{@ssl_server.generate}
EOCONFIGURATION

        output.strip
      end
    end
  end
end
