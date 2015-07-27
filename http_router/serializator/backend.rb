module HttpRouter
  module Serializator
    module Backend

      def self.create(backend)
        case backend.class.name
        when HttpRouter::Backend::TCP.name then Serializator::Backend::TCP.new(backend)
        when HttpRouter::Backend::UnixSocket.name then Serializator::Backend::UnixSocket.new(backend)
        else
          raise NotImplementedError, "Serializator for #{backend.class} backend is not jet implemented"
        end
      end
    end
  end
end
