# HttpRouter module
#
module HttpRouter
  autoload :Application,    './http_router/application'
  autoload :SSLCertificate, './http_router/ssl_certificate'

  module Backend
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

  module Serializator
    autoload :Application, './http_router/serializator/application'
    autoload :SSL,         './http_router/serializator/ssl'
    autoload :Backend,     './http_router/serializator/backend'

    module Backend
      autoload :Base,       './http_router/serializator/backend/base'
      autoload :TCP,        './http_router/serializator/backend/tcp'
      autoload :UnixSocket, './http_router/serializator/backend/unix_socket'
    end
  end
end
