shared_examples 'ssl server generator' do
  before do
    build_application

    @pattern_0 = create_ssl_pattern('example.com www.example.com', 0)
    @pattern_1 = create_ssl_pattern('ssl.example.com', 1)
  end

  it 'should generate ssl server for all SSL Certificate added to Application object' do
    add_certificates
    generator = subject.call

    expect(generator.generate).to match(/^#{@pattern_0}$/m)
    expect(generator.generate).to match(/^#{@pattern_1}$/m)
  end

  it 'shouldn\'t generate output if no ssl certificates are added' do
    generator = subject.call

    expect(generator.generate).not_to match(/^#{@pattern_0}$/m)
    expect(generator.generate).not_to match(/^#{@pattern_1}$/m)
  end
end
