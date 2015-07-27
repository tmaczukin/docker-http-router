module HttpRouter
  module Serializator

    describe Application do
      it 'should serialize application to YAML' do
        build_application
        add_certificates
        add_backends
        require_ssl

        serializator = Application.create_from_application(@app)

        pattern =
          '---\n' \
          'name: example\n' \
          'ssl_required: true\n' \
          'hostnames:\n' \
          '- example.com\n' \
          '- www.example.com\n' \
          '- ssl.example.com\n' \
          'backends:\n' \
          '- type: tcp\n' \
          '  ip: 127.0.0.2\n' \
          '  port: 8888\n' \
          '- type: unix_socket\n' \
          '  path: "/tmp/application.sock"\n' \
          'ssl_certificates:\n' \
          '- key: |-\n' \
          '    key\n' \
          '    content\n' \
          '  certificate: |-\n' \
          '    certificate\n' \
          '    content\n' \
          '  hostnames:\n' \
          '  - example.com\n' \
          '  - www.example.com\n' \
          '- key: |-\n' \
          '    key\n' \
          '    content\n' \
          '  certificate: |-\n' \
          '    certificate\n' \
          '    content\n' \
          '  hostnames:\n' \
          '  - ssl.example.com\n' \
          '  ca_certificates: |-\n' \
          '    ca\n' \
          '    bundle\n' \
          '    certificates\n'

        expect(serializator.serialize).to match(/^#{pattern}$/m)
      end

      context 'unserializing application from YAML' do
        subject do
          example_file = File.expand_path("#{File.dirname(__FILE__)}/../example.yml")
          @serialized_application = ''
          File.open(example_file) do |file|
            @serialized_application = file.read
          end

          -> { Application.load_from_yaml(@serialized_application) }
        end

        it 'should generate HttpRouter::Application object' do
          application = subject.call.unserialize

          expect(application).to be_a(HttpRouter::Application)
        end

        it 'should set ssl_required flag' do
          application = subject.call.unserialize

          expect(application.ssl_required).to be true
        end

        it 'should set all hostnames (literal and from ssl certificates)' do
          application = subject.call.unserialize

          expect(application.hostnames.count).to eq(3)
          expect(application.hostnames).to include('example.com')
          expect(application.hostnames).to include('www.example.com')
          expect(application.hostnames).to include('ssl.example.com')
        end

        it 'should set all backendss' do
          application = subject.call.unserialize

          expect(application.backends.count).to eq(2)
          expect(application.backends[0]).to be_a(HttpRouter::Backend::TCP)
          expect(application.backends[0].ip).to eq('127.0.0.2')
          expect(application.backends[0].port).to eq(8888)
          expect(application.backends[1]).to be_a(HttpRouter::Backend::UnixSocket)
          expect(application.backends[1].path).t eq('/tmp/application.sock')
        end

        it 'should set all ssl certificates' do
          application = subject.call.unserialize

          expect(application.ssl_certificates.count). to eq(2)
        end
      end
    end
  end
end
