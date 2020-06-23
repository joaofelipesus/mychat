require 'rails_helper'

RSpec.describe "TeamUsers", type: :request do

  describe 'create' do

    before :each do
      @current_user = create(:user)
      create(:team)
      @other_user = create(:user)
    end

    context 'when user is logged in' do
      before :each do
        sign_in @current_user
      end
      context 'when user is already in group' do
        before :each do
          create(:team_user, user: @other_user)
          post '/team_users', params: { team_user: { team_id: Team.last.id, user_id: @other_user.id }}
        end
        it 'is expected to return :unprocessable_entity' do
          expect(response).to have_http_status :unprocessable_entity
        end
        it 'is expected to return error message' do
          response_body = JSON.parse response.body
          expect(response_body["errors"].first).to match "Team has already been taken"
        end
      end
      context 'when current user isnt the team owner' do
        before :each do
          team = Team.last
          team.update owner: @other_user
          third_user = create(:user)
          post '/team_users', params: { team_user: { user_id: third_user.id, team_id: Team.last.id }}
        end
        it 'is expected to return status :forbidden' do
          expect(response).to have_http_status :forbidden
        end
      end
      context 'when params are ok' do
        before :each do
          post "/team_users", params: { team_user: { team_id: Team.last.id, user_id: @other_user.id }}
        end
        it 'is expected to return status created' do
          expect(response).to have_http_status :created
        end
        it 'is expected to return team_user created' do
          response_body = JSON.parse response.body
          team_user = response_body["team_user"]
          expect(team_user["team_id"]).to match Team.last.id
          expect(team_user["user_id"]).to match @other_user.id
          expect(team_user["inviting_status"]).to match "pending"
        end
      end
    end
    context 'when user isnt logged in' do
      before :each do
        post "/team_users", params: { team_user: { team_id: Team.last.id, user_id: @other_user.id }}
      end
      it 'is expecteced to return status :found' do
        expect(response).to have_http_status :found
      end
    end

  end

end
