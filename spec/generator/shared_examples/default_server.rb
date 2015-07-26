shared_examples 'default server generator' do
  before do
    build_application
    add_hostnames

    @pattern =
      'server {\n'                                                    \
      '  listen 80;\n'                                                \
      '  server_name example.com www.example.com test.example.com;\n' \
      '\n'                                                            \
      '  location / {\n'                                              \
      '    include proxy_params;\n'                                   \
      '    proxy_pass http://app_example;\n'                          \
      '  }\n'                                                         \
      '}'
  end

  it 'should generate default server configuration for Application object' do
    generator = subject.call

    expect(generator.generate).to match(/^#{@pattern}$/m)
  end

  it 'shouldn\'t generate output for SSL Required Application object' do
    require_ssl
    generator = subject.call

    expect(generator.generate).not_to match(/^#{@pattern}$/m)
  end
end
