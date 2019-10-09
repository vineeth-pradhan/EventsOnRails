require 'rails_helper'

describe Event, type: :model do
  describe 'associations' do
    it { should have_many(:rsvps) }
    it { should have_many(:users).through(:rsvps) }
  end

  describe 'validations' do
    context 'mandatory presence' do
      subject { create(:event_with_endtime) }

      it { should validate_presence_of(:title) }
      it { should validate_presence_of(:starttime) }
    end

    context 'conditional presence' do
      context 'allday event' do
        subject { create(:allday_event) }

        it { should_not validate_presence_of(:endtime) }
      end

      context 'not an allday event' do
        subject { create(:event_with_endtime) }

        it { should validate_presence_of(:endtime) }
      end
    end
  end

  describe 'callbacks' do
    context '#check_validity' do
      context 'when it is an allday event' do
        subject { create(:allday_event) }

        it 'should set endtime to nil' do
          expect(subject.endtime).to be_nil
        end

        it 'starttime should not be nil' do
          expect(subject.starttime).to_not be_nil
        end
      end

      context 'when it is not an allday event' do
        subject { create(:event_with_endtime) }

        it 'endtime should not be nil' do
          expect(subject.endtime).to_not be_nil
        end

        it 'starttime should not be nil' do
          expect(subject.starttime).to_not be_nil
        end
      end
    end

    context '#check_completion' do
      context 'when the event is in the future' do
        subject { create(:future_event) }

        it 'should set completed to false' do
          expect(subject.complete).to be_falsey
        end
      end

      context 'when the endtime has passed the current date' do
        subject { create(:event_with_endtime) }

        it 'should set completed to false' do
          expect(subject.complete).to be_truthy
        end
      end
    end
  end

  describe 'Event#validate?' do
    context 'when only starttime is passed' do
      context 'with a valid date 20/12/1999' do
        it 'must return true' do
          expect(Event.validate? starttime: '1999/12/20').to be_truthy
          expect(Event.validate? starttime: '20/12/1999').to be_truthy
        end
      end

      context 'with 29 Feb which is not a leap year' do
        it 'must return false' do
          expect(Event.validate? starttime: '29/02/2001').to be_falsey
          expect(Event.validate? starttime: '2001/02/29').to be_falsey
        end
      end

      context 'with an invalid month' do
        it 'must return false' do
          expect(Event.validate? starttime: '1999/99/20').to be_falsey
          expect(Event.validate? starttime: '20/99/1999').to be_falsey
        end
      end

      context 'with an invalid day' do
        it 'must return false' do
          expect(Event.validate? starttime: '1999/01/99').to be_falsey
          expect(Event.validate? starttime: '99/99/1999').to be_falsey
        end
      end
    end

    context 'when only endtime is passed' do
      context 'with a valid date 20/12/1999' do
        it 'must return true' do
          expect(Event.validate? endtime: '1999/12/20').to be_truthy
          expect(Event.validate? endtime: '20/12/1999').to be_truthy
        end
      end

      context 'with 29 Feb which is not a leap year' do
        it 'must return false' do
          expect(Event.validate? endtime: '29/02/2001').to be_falsey
          expect(Event.validate? endtime: '2001/02/29').to be_falsey
        end
      end

      context 'with an invalid month' do
        it 'must return false' do
          expect(Event.validate? endtime: '1999/99/20').to be_falsey
          expect(Event.validate? endtime: '20/99/1999').to be_falsey
        end
      end

      context 'with an invalid day' do
        it 'must return false' do
          expect(Event.validate? endtime: '1999/01/99').to be_falsey
          expect(Event.validate? endtime: '99/99/1999').to be_falsey
        end
      end
    end

    context 'when both starttime & endtime is passed' do
      context 'with both dates being valid' do
        it 'must return true' do
          expect(Event.validate? starttime: '1999/12/19', endtime: '1999/12/20').to be_truthy
          expect(Event.validate? starttime: '19/12/1999', endtime: '20/12/1999').to be_truthy
        end
      end

      context 'with endtime as 29 Feb which is not a leap year' do
        it 'must return false' do
          expect(Event.validate? starttime: '28/02/2001', endtime: '29/02/2001').to be_falsey
          expect(Event.validate? starttime: '2001/02/28', endtime: '2001/02/29').to be_falsey
        end
      end

      context 'with an invalid month in endtime' do
        it 'must return false' do
          expect(Event.validate? starttime: '1999/01/19', endtime: '1999/99/20').to be_falsey
          expect(Event.validate? starttime: '19/01/1999', endtime: '20/99/1999').to be_falsey
        end
      end

      context 'with an invalid day in endtime' do
        it 'must return false' do
          expect(Event.validate? starttime: '1999/01/19', endtime: '1999/01/99').to be_falsey
          expect(Event.validate? starttime: '19/01/1999', endtime: '99/01/1999').to be_falsey
        end
      end
    end
  end
end
