require 'rails_helper'

RSpec.describe Group, type: :model do

  describe 'create new group' do
    before :each do
      create(:user)
      create(:team)
      @group = build(:group)
    end
    context 'a group is invalid when' do
      after(:each) { expect(@group).to be_invalid }
      it 'doesnt have a team' do
        @group.team = nil
      end
      it 'doesnt have a slug' do
        @group.slug = ''
      end
      it 'doesnt have a owner' do
        @group.owner = nil
      end
      it 'its slug is already in use on same group' do
        create(:group, slug: 'nerv')
        @group.slug = 'nerv'
      end
      it 'is invalid when slug isnt formed only by chars' do
        @group.slug = 'N.E.R.V_Unity_02'
      end
    end
    context 'a group is valid' do
      it 'is expected to be_valid when its slug isnt already in use' do
        @group.slug = 'someunusedslug'
        expect(@group).to be_valid
      end
    end
  end


end
