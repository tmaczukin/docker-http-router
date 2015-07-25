describe HttpRouter::Application do

  context 'hostnames' do

    before do
      module HttpRouter
        class Application
          attr_writer :hostnames
        end
      end
    end

    subject do
      lambda do
        app = HttpRouter::Application.new
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
end
