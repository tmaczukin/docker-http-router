module HttpRouter
  module Serializator
    module Backend
      class Base

        def initialize(backend)
          @backend = backend
        end

        def serialize
          raise NotImplementedError
        end
      end
    end
  end
end
