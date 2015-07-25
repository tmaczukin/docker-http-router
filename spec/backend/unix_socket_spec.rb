require 'backend/base.rb'

module HttpRouter
  module Backend

    describe UnixSocket do
      subject do
        -> { UnixSocket.new('/tmp/application.sock') }
      end

      it_behaves_like 'base backend'

      it 'should return unix socket server link' do
        socket = subject.call

        expect(socket.link).to match(/^unix:\/\/\/tmp\/application\.sock$/)
      end

      it 'should return unix socket path value' do
        socket = subject.call

        expect(socket.path).to match(/^\/tmp\/application\.sock$/)
      end
    end
  end
end
