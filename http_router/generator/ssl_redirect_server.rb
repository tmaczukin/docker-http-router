module HttpRouter
  module Generator
    class SSLRedirectServer < DefaultServer

      def generate
        return '' unless @application.ssl_required

        <<EOSERVER
server {
  listen 80;
  server_name #{hostnames};

  rewrite ^(.*)$ https://$http_host/$1 last;
}
EOSERVER

      end
    end
  end
end
