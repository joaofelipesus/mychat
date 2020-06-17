require 'rails_helper'

RSpec.describe GroupUser, type: :model do

  describe 'create new GroupUsr' do
    before :each do
      create(:user)
      create(:team)
      create(:user)
      @group_user = build(:group_user)
    end

    context 'it is invalid when' do
      after(:each) { expect(@group_user).to be_invalid }
      it 'is invalid when missing user' do
        @group_user.user = nil
      end
      it 'is invalid when missing group' do
        @group_user.group = nil
      end
    end
    context 'when params are ok' do
      it 'is expected to be_valid' do
        expect(@group_user).to be_valid
      end
      it 'is expected to have invite_status as :pending' do
        expect(@group_user).to be_valid
        expect(@group_user.pending?).to be_truthy
      end
    end

  end

end
