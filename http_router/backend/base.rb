module HttpRouter
  module Backend
    class Base

      def link
        raise NotImplementedError
      end
    end
  end
end
