module HttpRouter
  module Serializator
    module Backend

      describe TCP do
        before do
          @backend = HttpRouter::Backend::TCP.new('127.0.0.2', 8888)
        end

        subject do
          -> { Serializator::Backend::TCP.new(@backend) }
        end

        it 'should generate a hash' do
          serializator = subject.call

          expect(serializator.serialize).to be_a(Hash)
        end

        it 'should have a \'type\' key with \'tcp\' value in generated hash' do
          serializator = subject.call

          expect(serializator.serialize).to have_key('type')
          expect(serializator.serialize['type']).to eq('tcp')
        end

        it 'should have a \'ip\' key with ip address value in generated hash' do
          serializator = subject.call

          expect(serializator.serialize).to have_key('ip')
          expect(serializator.serialize['ip']).to eq('127.0.0.2')
        end

        it 'should have a \'port\' key with port value in generated hash' do
          serializator = subject.call

          expect(serializator.serialize).to have_key('port')
          expect(serializator.serialize['port']).to eq(8888)
        end
      end
    end
  end
end
