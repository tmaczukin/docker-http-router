require 'generator/shared_examples/default_server'

module HttpRouter
  module Generator

    describe DefaultServer do
      subject do
        -> { DefaultServer.new(@app, 'app_example') }
      end

      it_behaves_like 'default server generator'
    end
  end
end
