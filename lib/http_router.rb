# HttpRouter module
#
module HttpRouter
  autoload :Application,    'http_router/application'
  autoload :Backend,        'http_router/backend'
  autoload :SSLCertificate, 'http_router/ssl_certificate'

  module Backend
    autoload :Base,       'http_router/backend/base'
    autoload :TCP,        'http_router/backend/tcp'
    autoload :UnixSocket, 'http_router/backend/unix_socket'
  end
end
