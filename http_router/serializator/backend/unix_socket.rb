module HttpRouter
  module Serializator
    module Backend
      class UnixSocket < Base

        def serialize
          {
            'type' => 'unix_socket',
            'path' => @backend.path
          }
        end
      end
    end
  end
end
