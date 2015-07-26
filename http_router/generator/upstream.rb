module HttpRouter
  module Generator
    class Upstream

      def initialize(application)
        @application = application
      end

      def generate
#        return '' if @application.backends.empty?

        <<EOUPSTREAM
upstream #{name} {
#{server_list}
}
EOUPSTREAM
      end

      def name
        "app_#{@application.name}"
      end

      private

      def server_list
        output = []

        @application.backends.each do |backend|
          output << "  server #{backend.link};"
        end

        output.join("\n")
      end
    end
  end
end
