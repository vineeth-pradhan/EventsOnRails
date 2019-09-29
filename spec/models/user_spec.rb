require 'rails_helper'

describe User, type: :model do
  describe 'associations' do
    it { should have_many(:events).through(:rsvps) }
    it { should have_many(:rsvps) }
  end

  describe 'validations' do
    context 'presence' do
      it { should validate_presence_of(:username) }
      it { should validate_presence_of(:email) }
      it { should_not validate_presence_of(:phone) }
    end

    context 'uniqueness' do
      it { should validate_uniqueness_of(:username) }
      it { should validate_uniqueness_of(:email) }
      it { should_not validate_uniqueness_of(:phone) }
    end
  end
end
