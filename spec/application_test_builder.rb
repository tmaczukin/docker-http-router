module ApplicationTestBuilder

  def build_application
    @app = HttpRouter::Application.new('example')
    @app.ssl_required = false
  end

  def require_ssl
    @app.ssl_required = true
  end

  def add_certificates
    @cert_1 = HttpRouter::SSLCertificate.new('key content', 'certificate content',
                                             ['example.com', 'www.example.com'])
    @cert_2 = HttpRouter::SSLCertificate.new('key content', 'certificate content',
                                             ['ssl.example.com'])
    @app.add_ssl_certificate(@cert_1)
    @app.add_ssl_certificate(@cert_2)
  end

  def add_backends
    @backend_1 = HttpRouter::Backend::TCP.new('127.0.0.2', 8888)
    @backend_2 = HttpRouter::Backend::UnixSocket.new('/tmp/application.sock')
    @app.add_backend(@backend_1)
    @app.add_backend(@backend_2)
  end

  def add_hostnames
    @app.add_hostname('example.com')
    @app.add_hostname('www.example.com')
    @app.add_hostname('test.example.com')
  end

  def create_ssl_pattern(hostnames, cert_id)
    pattern =
      'server {\n'                                                   \
      '  listen 443 ssl;\n'                                          \
      "  server_name #{hostnames};\n"                                \
      '\n'                                                           \
      "  ssl_certificate ssl/app_example_cert_#{cert_id}.crt;\n"     \
      "  ssl_certificate_key ssl/app_example_cert_#{cert_id}.key;\n" \
      '\n'                                                           \
      '  location / {\n'                                             \
      '    include proxy_params;\n'                                  \
      '    proxy_pass http://app_example;\n'                         \
      '  }\n'                                                        \
      '}'

    pattern
  end
end
