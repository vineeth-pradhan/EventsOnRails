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
end
