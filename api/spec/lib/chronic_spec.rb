require "#{File.join(__dir__, '..', '..', 'lib/chronic')}"

describe Chronic::Generic do
  describe '#valid?' do
    context 'when a single date string is passed' do
      describe 'with a valid date format "2010/10/10"' do
        let(:string) { '2010/10/10' }
        let(:time) { Time.new(string) }

        before do
          expect(Chronic).to receive(:parse).with(string).and_return(time)
        end

        it 'should return true' do
          expect(Chronic::Generic.valid? string).to eq(true)
        end
      end

      describe 'with an invalid month "2010/99/10"' do
        let(:string) { '2010/99/10' }
        let(:time) { Time.new(string) }

        before do
          expect(Chronic).to receive(:parse).with(string).and_return(nil)
        end

        it 'should return false' do
          expect(Chronic::Generic.valid? string).to eq(false)
        end
      end

      describe 'with an invalid date "2010/09/99"' do
        let(:string) { '2010/09/99' }
        let(:time) { Time.new(string) }

        before do
          expect(Chronic).to receive(:parse).with(string).and_return(nil)
        end

        it 'should return false' do
          expect(Chronic::Generic.valid? string).to eq(false)
        end
      end

      describe 'with an invalid date and month "2010/99/99"' do
        let(:string) { '2010/99/99' }
        let(:time) { Time.new(string) }

        before do
          expect(Chronic).to receive(:parse).with(string).and_return(nil)
        end

        it 'should return false' do
          expect(Chronic::Generic.valid? string).to eq(false)
        end
      end
    end

    context 'when 2 date strings are passed' do
      before do
        expect(Chronic).to receive(:parse).with(first_string).and_return(first_time)
      end

      describe 'and the first date is valid' do
        let(:first_string) { '2010/10/10' }
        let(:first_time) { Time.new(first_string) }

        describe 'and the month of the second date is invalid' do
          before do
            expect(Chronic).to receive(:parse).with(second_string).and_return(nil)
          end

          let(:second_string) { '2010/99/01' }
          it 'should return false' do
            expect(Chronic::Generic.valid? *[first_string, second_string]).to eq(false)
          end
        end

        describe 'and the day of the second date is invalid' do
          before do
            expect(Chronic).to receive(:parse).with(second_string).and_return(nil)
          end

          let(:second_string) { '2010/01/99' }

          it 'should return false' do
            expect(Chronic::Generic.valid? *[first_string, second_string]).to eq(false)
          end
        end

        describe 'and the year of the second date is an astronomical number' do
          let(:second_string) { '9999/01/01' }
          let(:second_time) { Time.new(second_string) }

          before do
            expect(Chronic).to receive(:parse).with(second_string).and_return(second_time)
          end

          it 'should return true' do
            expect(Chronic::Generic.valid? *[first_string, second_string]).to eq(true)
          end
        end
      end

      describe 'and the second date is valid' do
        pending
        let(:second_string) { '2010/10/10' }
        let(:second_time) { Time.new(second_string) }

        describe 'and the month of the first date is invalid' do
          let(:first_string) { '2010/99/99' }
          let(:first_time) { Time.new(first_string) }
        end

        describe 'and the day of the first date is invalid' do
          let(:first_string) { '2010/99/99' }
          let(:first_time) { Time.new(first_string) }
        end

        describe 'and the year of the first date is an astronomical number' do
          let(:first_string) { '2010/99/99' }
          let(:first_time) { Time.new(first_string) }
        end
      end
    end
  end
end
