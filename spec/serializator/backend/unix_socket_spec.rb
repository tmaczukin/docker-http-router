module HttpRouter
  module Serializator
    module Backend

      describe UnixSocket do
        before do
          @backend = HttpRouter::Backend::UnixSocket.new('/tmp/application.sock')
        end

        subject do
          -> { Serializator::Backend::UnixSocket.new(@backend) }
        end

        it 'should generate a hash' do
          serializator = subject.call

          expect(serializator.serialize).to be_a(Hash)
        end

        it 'should have a \'type\' key with \'unix_path\' value in generated hash' do
          serializator = subject.call

          expect(serializator.serialize).to have_key('type')
          expect(serializator.serialize['type']).to eq('unix_socket')
        end

        it 'should have a \'path\' key with path to socket value in generated hash' do
          serializator = subject.call

          expect(serializator.serialize).to have_key('path')
          expect(serializator.serialize['path']).to eq('/tmp/application.sock')
        end
      end
    end
  end
end
