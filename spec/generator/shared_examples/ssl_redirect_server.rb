shared_examples 'ssl redirect server generator' do
  before do
    build_application
    add_hostnames

    @pattern =
      'server {\n'                                                    \
      '  listen 80;\n'                                                \
      '  server_name example.com www.example.com test.example.com;\n' \
      '\n'                                                            \
      '  rewrite \^\(\.\*\)\$ https://\$http_host/\$1 last;\n'        \
      '}'
  end

  it 'should generate ssl redirect server configuration for Application object' do
    require_ssl
    generator = subject.call

    expect(generator.generate).to match(/^#{@pattern}/m)
  end

  it 'shouldn\'t generate output for standard Application object' do
    generator = subject.call

    expect(generator.generate).not_to match(/^#{@pattern}$/m)
  end
end
