module HttpRouter
  module Generator
    class SSLServer < DefaultServer

      def generate
        return '' if @application.ssl_certificates.empty?

        output = []
        @application.ssl_certificates.each_with_index do |certificate, index|
          output << generate_server(certificate, index)
        end

        output.compact.join("\n").strip
      end

      private

      def generate_server(certificate, id)
        output = <<EOSERVER
server {
  listen 443 ssl;
  server_name #{certificate.hostnames.join(' ')};

  ssl_certificate ssl/app_#{@application.name}_cert_#{id}.crt;
  ssl_certificate_key ssl/app_#{@application.name}_cert_#{id}.key;

  location / {
    include proxy_params;
    proxy_pass http://#{@upstream_name};
  }
}
EOSERVER

        output.strip
      end
    end
  end
end
