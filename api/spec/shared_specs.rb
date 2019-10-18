shared_examples 'valid event' do
  it 'should return true' do
    expect(Chronic::Event.valid? *args).to eq(true)
  end
end

shared_examples 'invalid event' do
  it 'should return false' do
    expect(Chronic::Event.valid? *args).to eq(false)
  end
end

shared_examples 'truthy' do
  it 'should return true' do
    expect(Chronic::Generic.valid? *args).to eq(true)
  end
end

shared_examples 'falsey' do
  it 'should return false' do
    expect(Chronic::Generic.valid? *args).to eq(false)
  end
end

shared_context 'falsey pair' do
  describe 'and the month of the first date is invalid' do
    let(:bad_string) { '2010/99/01' }

    it_behaves_like 'falsey'
  end

  describe 'and the day of the first date is invalid' do
    let(:bad_string) { '2010/01/99' }

    it_behaves_like 'falsey'
  end

  describe 'and the day is 29th feb of a non leap year' do
    let(:bad_string) { '29/02/2011' }

    it_behaves_like 'falsey'
  end

  describe 'and the year of the first date is an astronomical number' do
    let(:bad_string) { '9999999/01/01' }

    it_behaves_like 'falsey'
  end
end
