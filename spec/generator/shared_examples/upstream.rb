shared_examples 'upstream generator' do
  before do
    build_application

    @pattern =
      'upstream app_example {\n'                 \
      '  server 127.0.0.2:8888;\n'               \
      '  server unix:///tmp/application.sock;\n' \
      '}'
  end

  it 'should generate upstream configuration for Application object' do
    add_backends
    generator = subject.call

    expect(generator.generate).to match(/^#{@pattern}$/m)
  end

  it 'shouldn\'t generate upstream section if no backends are added' do
    generator = subject.call

    expect(generator.generate).not_to match(/^#{@pattern}$/m)
  end
end
