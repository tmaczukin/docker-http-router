require 'generator/shared_examples/upstream'
require 'generator/shared_examples/default_server'
require 'generator/shared_examples/ssl_server'
require 'generator/shared_examples/ssl_redirect_server'

module HttpRouter
  module Generator

    describe Application do
      subject do
        -> { Application.new(@app) }
      end

      it_behaves_like 'upstream generator'
      it_behaves_like 'default server generator'
      it_behaves_like 'ssl redirect server generator'
      it_behaves_like 'ssl server generator'
    end
  end
end
