require 'rails_helper'

RSpec.describe Message, type: :model do

  describe 'create new message' do
    before :each do
      create(:user)
      create(:team)
      @message = build(:message)
    end
    context 'is invalid when' do
      after(:each) { expect(@message).to be_invalid }
      it 'is expected to be_invalid when missing body' do
        @message.body = ''
      end
      it 'is expected to be_invalid when missing group' do
        @message.group = nil
      end
      it 'is expected to be_invalid when missing user' do
        @message.user = nil
      end
    end
    context 'when all params are ok' do
      it 'is expected to be_valid' do
        expect(@message).to be_valid
      end
    end
  end

end
