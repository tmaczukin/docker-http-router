require 'generator/shared_examples/upstream'

module HttpRouter
  module Generator

    describe Upstream do
      subject do
        -> { Upstream.new(@app) }
      end

      it 'should return upstream name value' do
        build_application
        generator = subject.call

        expect(generator.name).to match(/^app_example$/)
      end

      it_behaves_like 'upstream generator'
    end
  end
end
