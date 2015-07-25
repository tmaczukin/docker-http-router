shared_examples 'base backend' do
  it 'should return backend link' do
    expect(subject.call.link).to match(/^.+$/)
  end
end
