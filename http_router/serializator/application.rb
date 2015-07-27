require 'yaml'

module HttpRouter
  module Serializator
    class Application
      attr_writer :application, :yaml

      def self.create_from_application(application)
        serializator = self.new
        serializator.application = application

        serializator
      end

      def self.load_from_yaml(serialized_string)
        serializator = Application.new
        serializator.yaml = serialized_string

        serializator
      end

      def serialize
        hash = {
          'name' => @application.name
        }

        hash['ssl_required'] = @application.ssl_required if @application.ssl_required
        hash['hostnames'] = @application.hostnames if @application.hostnames
        hash['backends'] = serialize_backends(@application.backends) if @application.backends
        hash['ssl_certificates'] =
          serialize_ssl_certificates(@application.ssl_certificates) if @application.ssl_certificates

        hash.to_yaml
      end

      def unserialize
        parsed_yaml = YAML.load(@yaml)

        application = HttpRouter::Application.new(parsed_yaml['name'])
        application.ssl_required = parsed_yaml['ssl_required'] if parsed_yaml['ssl_required']

        parsed_yaml['hostnames'].each do |hostname|
          application.add_hostname(hostname)
        end if parsed_yaml['hostnames']

        application
      end

      private

      def serialize_backends(backends)
        backends.map do |backend|
          Serializator::Backend.create(backend).serialize
        end
      end

      def serialize_ssl_certificates(ssl_certificates)
        ssl_certificates.map do |certificate|
          Serializator::SSL.new(certificate).serialize
        end
      end
    end
  end
end
