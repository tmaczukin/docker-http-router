require 'backend/shared_examples/base.rb'

module HttpRouter
  module Backend

    describe TCP do
      it_behaves_like 'base backend'

      subject do
        -> { TCP.new('127.0.0.2', 8888) }
      end

      it 'should return ip:port server link' do
        tcp = subject.call

        expect(tcp.link).to match(/^127\.0\.0\.2:8888$/)
      end

      it 'should return IP value' do
        tcp = subject.call

        expect(tcp.ip).to match(/^127\.0\.0\.2/)
      end

      it 'should return port value' do
        tcp = subject.call

        expect(tcp.port).to eq(8888)
      end

      it 'should raise an exception when initialized with invalid IP' do
        expect { TCP.new('300.a.0.0', 8888) }.to raise_error(ArgumentError, /^Invalid IP address: 300\.a\.0\.0$/)
      end

      it 'should raise an exception when initialized with invalid port' do
        expect { TCP.new('127.0.0.2', 0) }.to raise_error(ArgumentError, /^Invalid port: 0$/)
      end
    end
  end
end
