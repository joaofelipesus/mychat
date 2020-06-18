require 'rails_helper'

RSpec.describe TeamUser, type: :model do

  describe 'create a new TeamUser' do
    context 'TeamUser is iinvalid when' do
      before :each do
        create(:user)
        create(:team)
        current_user = create(:user)
        @team_user = build(:team_user, user: current_user)
      end
      after :each do
        expect(@team_user).to be_invalid
      end
      it 'is invalid when without team' do
        @team_user.team = nil
      end
      it 'is invalid when without user' do
        @team_user.user = nil
      end
      it 'is invalid when user already is member of the team' do
        create(:team_user)
      end
    end
    context 'when all params are ok' do
      before :each do
        create(:user)
        create(:team)
        @current_user = create(:user)
      end
      it 'is expected to have invite_status :pending' do
        team_user = build(:team_user, user: @current_user)
        expect(team_user).to be_valid
        expect(team_user.pending?).to be_truthy
      end
    end
  end

end
