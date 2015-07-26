# HttpRouter module
#
module HttpRouter
  autoload :Application,    './http_router/application'
  autoload :Backend,        './http_router/backend'
  autoload :SSLCertificate, './http_router/ssl_certificate'
  autoload :Generator,      './http_router/generator'

  module Backend
    autoload :Base,       './http_router/backend/base'
    autoload :TCP,        './http_router/backend/tcp'
    autoload :UnixSocket, './http_router/backend/unix_socket'
  end

  module Generator
    autoload :Application,       './http_router/generator/application'
    autoload :Upstream,          './http_router/generator/upstream'
    autoload :DefaultServer,     './http_router/generator/default_server'
    autoload :SSLRedirectServer, './http_router/generator/ssl_redirect_server'
    autoload :SSLServer,         './http_router/generator/ssl_server'
  end
end
