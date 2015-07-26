require 'generator/shared_examples/ssl_server'

module HttpRouter
  module Generator

    describe SSLServer do
      subject do
        -> { SSLServer.new(@app, 'app_example') }
      end

      it_behaves_like 'ssl server generator'
    end
  end
end
