module HttpRouter
  describe Application do

    it 'should set name while creating object' do
      app = Application.new('example')

      expect(app.name).to eq('example')
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
  end
end
