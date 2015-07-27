module HttpRouter
  module Serializator

    describe SSL do
      before do
        @cert = HttpRouter::SSLCertificate.new("key\ncontent", "certificate\ncontent",
                                               ['example.com', 'www.example.com'])
      end

      subject do
        -> { SSL.new(@cert) }
      end

      it 'should generate a hash' do
        serializator = subject.call

        expect(serializator.serialize).to be_a(Hash)
      end

      it 'should have \'key\' key with key content value in generated hash' do
        serializator = subject.call

        expect(serializator.serialize).to have_key('key')
        expect(serializator.serialize['key']).to match(/^key\ncontent$/)
      end

      it 'should have \'certificate\' key with certificate content value in generated hash' do
        serializator = subject.call

        expect(serializator.serialize).to have_key('certificate')
        expect(serializator.serialize['certificate']).to match(/^certificate\ncontent$/)
      end

      it 'should have \'ca_certificates\' key with ca_certificates content value in generated hash if ' \
         'ca_certificates was set' do
        @cert.ca_certificates = "ca\ncertificates\ncontent"
        serializator = subject.call

        expect(serializator.serialize).to have_key('ca_certificates')
        expect(serializator.serialize['ca_certificates']).to match(/^ca\ncertificates\ncontent$/)
      end

      it 'shouldn\'t have \'ca_certificates\' key in generated hash if ca_certificates wasn\'t set' do
        serializator = subject.call

        expect(serializator.serialize).not_to have_key('ca_certificates')
      end

      it 'should have \'hostnames\' key with hostnames array in generated hash' do
        serializator = subject.call

        expect(serializator.serialize).to have_key('hostnames')
        expect(serializator.serialize['hostnames']).to include('example.com')
        expect(serializator.serialize['hostnames']).to include('www.example.com')
      end
    end
  end
end
