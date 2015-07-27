module HttpRouter
  module Serializator
    module Backend
      class TCP < Base

        def serialize
          {
            'type' => 'tcp',
            'ip' => @backend.ip,
            'port' => @backend.port
          }
        end
      end
    end
  end
end
