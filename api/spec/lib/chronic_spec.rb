require "#{File.join(__dir__, '..', '..', 'lib/chronic')}"

describe Chronic::Generic do
  describe '#valid?' do
    describe 'when a single valid date string is passed with "2010/10/10"' do
      let(:time_string) { '2010/10/10' }
      let(:time) { Time.new(time_string) }

      before do
        expect(Chronic).to receive(:parse).with(time_string).and_return(time)
      end

      it 'should return true' do
        expect(Chronic::Generic.valid? time_string).to eq(true)
      end
    end

    describe 'when an invalid month is passed with "2010/99/10"' do
      let(:time_string) { '2010/99/10' }
      let(:time) { Time.new(time_string) }

      before do
        expect(Chronic).to receive(:parse).with(time_string).and_return(nil)
      end

      it 'should return false' do
        expect(Chronic::Generic.valid? time_string).to eq(false)
      end
    end

    describe 'when an invalid date is passed with "2010/09/99"' do
      let(:time_string) { '2010/09/99' }
      let(:time) { Time.new(time_string) }

      before do
        expect(Chronic).to receive(:parse).with(time_string).and_return(nil)
      end

      it 'should return false' do
        expect(Chronic::Generic.valid? time_string).to eq(false)
      end
    end

    describe 'when an invalid date and month is passed with "2010/99/99"' do
      let(:time_string) { '2010/99/99' }
      let(:time) { Time.new(time_string) }

      before do
        expect(Chronic).to receive(:parse).with(time_string).and_return(nil)
      end

      it 'should return false' do
        expect(Chronic::Generic.valid? time_string).to eq(false)
      end
    end
  end
end
