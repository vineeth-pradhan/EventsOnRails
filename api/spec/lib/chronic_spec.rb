require "#{File.join(__dir__, '..', '..', 'lib/chronic')}"
require "#{File.join(__dir__, '..', 'shared_specs')}"

describe Chronic::Event do
  describe '#valid?' do
    context 'when nil is passed for both args' do
      let(:bad_string) { nil }
      let(:bad_string2) { nil }
      let(:args) { [bad_string, bad_string2] }
      let(:arg_returns) { nil }

      before do
        expect(Chronic).to receive(:parse).with(args[0]).and_return(arg_returns)
      end

      it_behaves_like 'invalid event'
    end

    context 'when only one argument is passed' do
      context 'and the arg is a valid date' do
        let(:good_string) { '2010/10/10' }
        let(:args) { good_string }
        let(:arg_returns) { [Time.new(*(good_string.split('/'))), nil] }

        it_behaves_like 'invalid event'
      end

      context 'and the arg is an invalid date' do
        let(:bad_string) { '2010/99/99' }
        let(:args) { bad_string  }
        let(:arg_returns) { nil }

        it_behaves_like 'invalid event'
      end
    end

    context 'when the first argument is nil' do
      let(:bad_string) { nil }
      let(:good_string) { '2010/10/10' }
      let(:args) { [bad_string, good_string] }
      let(:arg_returns) { nil }

      before do
        expect(Chronic).to receive(:parse).with(args[0]).and_return(arg_returns)
      end

      it_behaves_like 'invalid event'
    end

    context 'when the second argument is nil' do
      let(:bad_string) { nil }
      let(:good_string) { '2010/10/10' }
      let(:args) { [good_string, bad_string] }
      let(:arg_returns) { [Time.new(*(good_string.split('/'))), nil] }

      before do
        expect(Chronic).to receive(:parse).with(args[0]).and_return(arg_returns[0])
        expect(Chronic).to receive(:parse).with(args[1]).and_return(arg_returns[1])
      end

      it_behaves_like 'invalid event'
    end

    context 'when the arguments are valid with yyyy/mm/dd format' do
      let(:arg_returns) { [Time.new(*(good_string.split('/'))), Time.new(*(good_string2.split('/')))] }

      before do
        expect(Chronic::Generic).to receive(:valid?).with(*args).and_return(true)
        expect(Chronic).to receive(:parse).with(args[0]).and_return(arg_returns[0])
        expect(Chronic).to receive(:parse).with(args[1]).and_return(arg_returns[1])
      end

      context 'when first date occurs before the second date' do
        let(:good_string) { '2010/10/09' }
        let(:good_string2) { '2010/10/10' }
        let(:args) { [good_string, good_string2] }

        it_behaves_like 'valid event'
      end

      context 'when first date occurs after the second date' do
        let(:good_string) { '2010/10/10' }
        let(:good_string2) { '2010/10/09' }
        let(:args) { [good_string, good_string2] }

        it_behaves_like 'invalid event'
      end
    end
  end
end

describe Chronic::Generic do
  describe '#valid?' do
    context 'when no args are passed' do
      let(:args) { nil }
      it_behaves_like 'falsey'
    end

    context 'when a junk text is passed as args' do
      before do
        expect(Chronic).to receive(:parse).with(args).and_return(nil)
      end

      let(:args) { 'junk text' }
      it_behaves_like 'falsey'
    end

    context 'when a single date string is passed' do
      context  'and #parse returns non-nil' do
        describe 'with a valid date format "2010/10/10"' do
          let(:args) { '2010/10/10' }
          let(:time) { Time.new(args) }

          before do
            expect(Chronic).to receive(:parse).with(args).and_return(time)
          end

          it_behaves_like 'truthy'
        end
      end

      context  'and #parse returns nil' do
        before do
          expect(Chronic).to receive(:parse).with(args).and_return(nil)
        end

        describe 'with an invalid month "2010/99/10"' do
          let(:args) { '2010/99/10' }

          it_behaves_like 'falsey'
        end

        describe 'with an invalid date "2010/09/99"' do
          let(:args) { '2010/09/99' }

          it_behaves_like 'falsey'
        end

        describe 'with an invalid date and month "2010/99/99"' do
          let(:args) { '2010/99/99' }

          it_behaves_like 'falsey'
        end
      end
    end

    context 'when 2 date strings are passed' do
      let(:good_string) { '2010/10/10' }
      let(:good_time) { Time.new(good_string) }

      before do
        expect(Chronic).to receive(:parse).with(args[0]).and_return(arg_returns[0])
      end

      describe 'and the second date is invalid' do
        let(:args) { [good_string, bad_string] }
        let(:arg_returns) { [good_time, nil] }

        before do
          expect(Chronic).to receive(:parse).with(args[1]).and_return(arg_returns[1])
        end

        include_context 'falsey pair'
      end


      describe 'and the first date is invalid' do
        let(:args) { [bad_string, good_string] }
        let(:arg_returns) { [nil, good_time] }

        include_context 'falsey pair'
      end

      describe 'and both the strings are valid' do
        let(:good_string2) { '2010/10/09' }
        let(:good_time2) { Time.new(good_string2) }

        before do
          expect(Chronic).to receive(:parse).with(args[1]).and_return(arg_returns[1])
        end

        describe 'but the second date is in the past' do
          let(:args) { [good_string, good_string2] }
          let(:arg_returns) { [good_time, good_time2] }

          it_behaves_like 'truthy'
        end

        describe 'and the second date is in the future' do
          let(:args) { [good_string2, good_string] }
          let(:arg_returns) { [good_time2, good_time] }

          it_behaves_like 'truthy'
        end
      end
    end
  end
end
