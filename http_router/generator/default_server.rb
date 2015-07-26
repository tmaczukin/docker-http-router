module HttpRouter
  module Generator
    class DefaultServer

      def initialize(application, upstream_name)
        @application = application
        @upstream_name = upstream_name
      end

      def generate
        return '' if @application.ssl_required
        return '' if @application.hostnames.empty?

        <<EOSERVER
server {
  listen 80;
  server_name #{hostnames};

  location / {
    include proxy_params;
    proxy_pass http://#{@upstream_name};
  }
}
EOSERVER
      end

      private

      def hostnames
        @application.hostnames.join(' ')
      end
    end
  end
end
