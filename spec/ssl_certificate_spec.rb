module HttpRouter
  describe SSLCertificate do

    before do
      @key = "key\ncontent"
      @certificate = "certificate\ncontent"
    end

    subject do
      hostnames = [
        'example.com',
        'www.example.com'
      ]

      -> { SSLCertificate.new(@key, @certificate, hostnames) }
    end

    it 'should return key value' do
      cert = subject.call

      expect(cert.key).to match(/^key\ncontent$/)
    end

    it 'should return certificate value' do
      cert = subject.call

      expect(cert.certificate).to match(/^certificate\ncontent$/)
    end

    it 'should have ability to set ca certificates' do
      cert = subject.call
      cert.ca_certificates = "ca\ncertificates\ncontent"

      expect(cert.ca_certificates).to match(/^ca\ncertificates\ncontent$/)
    end

    it 'should return hostnames list' do
      cert = subject.call

      expect(cert.hostnames[0]).to match(/^example\.com$/)
      expect(cert.hostnames[1]).to match(/^www\.example\.com$/)
      expect(cert.hostnames.count).to eq(2)
    end

    it 'should raise an exception if hostnames is not an array' do
      hostnames = 'example.com'

      expect { SSLCertificate.new(@key, @certificate, hostnames) }
        .to raise_error(ArgumentError, /^Array of hostnames expected$/)
    end
  end
end
