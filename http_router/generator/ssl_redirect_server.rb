module HttpRouter
  module Generator
    class SSLRedirectServer < DefaultServer

      def generate
        return '' unless @application.ssl_required

        output = <<EOSERVER
server {
  listen 80;
  server_name #{hostnames};

  rewrite ^(.*)$ https://$http_host/$1 last;
}
EOSERVER

        output.strip
      end
    end
  end
end
