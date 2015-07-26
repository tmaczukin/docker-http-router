require 'generator/shared_examples/ssl_redirect_server'

module HttpRouter
  module Generator

    describe SSLRedirectServer do
      subject do
        -> { SSLRedirectServer.new(@app, 'app_example') }
      end

      it_behaves_like 'ssl redirect server generator'
    end
  end
end
