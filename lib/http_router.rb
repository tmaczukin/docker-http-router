# HttpRouter module
#
module HttpRouter
  autoload :Application, 'http_router/application'
  autoload :Backend,     'http_router/backend'

  module Backend
    autoload :Base,       'http_router/backend/base'
  end
end
