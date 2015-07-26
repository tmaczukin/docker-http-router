module HttpRouter
  module Backend
    class UnixSocket
      attr_reader :path

      def initialize(path)
        @path = path
      end

      def link
        "unix://#{@path}"
      end
    end
  end
end
