require 'rails_helper'

RSpec.describe User, type: :model do

  context 'create new user' do
    it 'is invalid when without name' do
      user = build(:user, name: '')
      expect(user).to be_invalid
    end
  end

  describe 'my_teams' do
    context 'when user is owner of a group' do
      before :each do
        @user = create(:user)
        create(:team)
      end
      it 'is expected to return 1 group' do
        expect(@user.reload.my_teams.size).to eq 1
      end
    end
    context 'when user only is member of groups' do
      before :each do
        create(:user)
        create(:team)
        @user = create(:user)
        create(:team_user, user: @user)
      end
      it 'is expected to return 1 group' do
        expect(@user.reload.my_teams.size).to eq 1
      end
    end
    context 'when user is owner of a group and member of other group' do
      before :each do
        @user = create(:user)
        create(:team, owner: @user, slug: 'nerv')
        other_user = create(:user)
        create(:team, owner: other_user, slug: 'evangelion')
        create(:team_user, user: @user)
      end
      it 'is expected to return 2 groups' do
        expect(@user.reload.my_teams.size).to eq 2
      end
    end
  end

end
