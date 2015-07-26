#!/usr/bin/env ruby

require 'pry'
require_relative '../http_router.rb'

app = HttpRouter::Application.new('example_application')
app.error_page = '<html><body><h1>error</h1></body></html>'
app.add_hostname('www.example.com')

backend_1 = HttpRouter::Backend::TCP.new('127.0.0.2', 20001)
backend_2 = HttpRouter::Backend::TCP.new('127.0.0.2', 20002)
app.add_backend(backend_1)
app.add_backend(backend_2)

cert_1 = HttpRouter::SSLCertificate.new('key', 'cert', ['example.com']);
cert_2 = HttpRouter::SSLCertificate.new('key', 'cert', ['ssl.example.com']);
app.add_ssl_certificate(cert_1)
app.add_ssl_certificate(cert_2)

#app.ssl_required = true

application_generator = HttpRouter::Generator::Application.new(app)
puts application_generator.generate

#binding.pry
