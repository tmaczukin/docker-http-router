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
#{@upstream.generate.strip}
#{@default_server.generate.strip}
#{@ssl_redirect_server.generate.strip}
#{@ssl_server.generate.strip}
EOCONFIGURATION

        output.strip
      end
    end
  end
end
