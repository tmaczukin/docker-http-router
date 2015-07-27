module HttpRouter
  module Serializator

    describe Backend do
      subject do
        -> { Serializator::Backend.create(@backend) }
      end

      it 'should return HttpRouter::Serializator::Backend::TCP serializator for HttpRouter::Backend::TCP backend' do
        @backend = HttpRouter::Backend::TCP.new('127.0.0.2', 8888)

        expect(subject.call).to be_a(HttpRouter::Serializator::Backend::TCP)
      end

      it 'should return HttpROuter::Serializator::Backend::UnixSocket serializator ' \
         'for HttpRouter::Backend::TCP backend' do
        @backend = HttpRouter::Backend::UnixSocket.new('/tmp/application.sock')

        expect(subject.call).to be_a(HttpRouter::Serializator::Backend::UnixSocket)
      end

      it 'should raise an exception when unknown backend type was provided' do
        @backend = "test"

        expect{ subject.call }.to raise_error(NotImplementedError, /^Serializator for .* backend is not jet implemented/)
      end
    end
  end
end
