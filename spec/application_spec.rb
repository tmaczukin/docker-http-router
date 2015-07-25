module HttpRouter
  describe Application do

    context 'general' do
      subject do
        -> {Application.new('example')}
      end

      it 'should set name while creating object' do
        app = subject.call

        expect(app.name).to eq('example')
      end

      it 'should have ability to set error_page content' do
        app = subject.call
        app.error_page = "<html><body><h1>Error</h1></body></html>"

        expect(app.error_page).to match(/<html><body><h1>Error<\/h1><\/body><\/html>/)
      end
    end

    context 'hostnames' do
      before do
        class Application
          attr_writer :hostnames
        end
      end

      subject do
        lambda do
          app = Application.new('example')
          app.hostnames = [
            'example.com',
            'www.example.com'
          ]
          app
        end
      end

      describe '#add_hostname' do
        it 'should update hostnames array while adding new hostname' do
          app = subject.call
          app.add_hostname('beta.example.com')

          expect(app.hostnames).to include('beta.example.com')
          expect(app.hostnames.count).to eq(3)
        end

        it 'shouldn\'t modify hostnames array while adding existing hostname' do
          app = subject.call
          app.add_hostname('www.example.com')

          expect(app.hostnames).to include('www.example.com')
          expect(app.hostnames.count).to eq(2)
        end
      end

      describe '#hostnames' do
        it 'should return all added hostnames' do
          app = subject.call

          expect(app.hostnames).to include('www.example.com')
          expect(app.hostnames).to include('example.com')
          expect(app.hostnames.count).to eq(2)
        end
      end
    end

    context 'backends' do
      before do
        @unix_backend_1 = Backend::UnixSocket.new('/tmp/application_1.sock')
        @unix_backend_2 = Backend::UnixSocket.new('/tmp/application_2.sock')

        class Application
          attr_writer :backends
        end
      end

      subject do
        lambda do
          app = Application.new('example')
          app.backends = [
            @unix_backend_1,
            @unix_backend_2
          ]
          app
        end
      end

      describe '#add_backend' do
        it 'should update backends array while adding new backend' do
          unix_backend_3 = Backend::TCP.new('127.0.0.2', 8888)

          app = subject.call
          app.add_backend(unix_backend_3)

          expect(app.backends).to include(unix_backend_3)
          expect(app.backends.count).to eq(3)
        end

        it 'shouldn\'t modify backends array while adding existing backend' do
          app = subject.call
          app.add_backend(@unix_backend_1)

          expect(app.backends).to include(@unix_backend_1)
          expect(app.backends.count).to eq(2)
        end
      end

      describe '#backends' do
        it 'should return all added backends' do
          app = subject.call

          expect(app.backends[0]).to eq(@unix_backend_1)
          expect(app.backends[1]).to eq(@unix_backend_2)
          expect(app.backends.count).to eq(2)
        end
      end
    end

    context 'requireing SSL' do
      it 'should have ability to mark application as "SSL required"' do
        app = Application.new('example')
        app.ssl_required = true

        expect(app.ssl_required).to be true
      end

      it 'should set ssl_required to true only if the argument is boolean TRUE' do
        app = Application.new('example')
        app.ssl_required = 'test'

        expect(app.ssl_required).to be false
      end
    end
  end
end
