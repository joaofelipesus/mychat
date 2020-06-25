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
          expect(team_user["team"]["slug"]).to match Team.last.slug
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

  describe '#destroy' do
    before :each do
      @current_user = create(:user)
      team_owner = create(:user)
      create(:team, owner: team_owner)
      @team_user = create(:team_user, user: @current_user)
    end
    context 'when current user isnt the same user of the invite' do
      before :each do
        @other_user = create(:user)
        sign_in @other_user
        delete "/team_users/#{@team_user.id}"
      end
      it 'is expected to return status forbidden' do
        expect(response).to have_http_status :forbidden
      end
    end
    context 'when current user is the user of the invite' do
      before :each do
        sign_in @current_user
        delete "/team_users/#{@team_user.id}"
      end
      it 'is expected to return status :ok' do
        expect(response).to have_http_status :ok
      end
      it 'is expected to destroy invite' do
        expect(TeamUser.count).to eq 0
      end
    end
    context 'if invite status isnt pending' do
      before :each do
        sign_in @current_user
        @team_user.update inviting_status: :confirmed
        delete "/team_users/#{@team_user.id}"
      end
      it 'is expected to return :forbidden' do
        expect(response).to have_http_status :forbidden
      end
    end
  end

  describe 'accept invite' do
    before :each do
      @current_user = create(:user)
      team_owner = create(:user)
      create(:team, owner: team_owner)
      @team_user = create(:team_user, user: @current_user)
    end
    context 'when user is logged in' do
      before :each do
        sign_in @current_user
      end
      context 'when current user isnt the user of the invite' do
        before :each do
          sign_out @current_user
          sign_in create(:user)
          patch "/team_users/#{@team_user.id}", params: { team_user: { inviting_status: :confirmed }}
        end
        it 'is expected to return :forbidden status' do
          expect(response).to have_http_status :forbidden
        end
      end
      context 'when invite is already confirmed' do
        before :each do
          @team_user.update inviting_status: :confirmed
          patch "/team_users/#{@team_user.id}", params: { team_user: { inviting_status: :confirmed }}
        end
        it 'is expected to return status :forbidden' do
          expect(response).to have_http_status :forbidden
        end
      end
      context 'when params are ok' do
        before :each do
          patch "/team_users/#{@team_user.id}", params: { team_user: { inviting_status: :confirmed }}
        end
        it 'is expected to return status :ok' do
          expect(response).to have_http_status :ok
        end
        it 'is expected to change inviting_status to :confirmed' do
          response_body = JSON.parse response.body
          expect(response_body["team_user"]["inviting_status"]).to match "confirmed"
        end
      end
    end
    context 'when user isnt logged in' do
      before :each do
        patch "/team_users/#{@team_user.id}", params: { team_user: { inviting_status: :confirmed }}
      end
      it 'is expected to return found status' do
        expect(response).to have_http_status :found
      end
    end
  end
  describe 'list current user invites' do
    before :each do
      @current_user = create(:user)
      team_owner = create(:user)
      create(:team, owner: team_owner)
      @current_user
      sign_in @current_user
    end
    context 'when user has team_user pending' do
      before :each do
        create(:team_user, user: @current_user)
        get "/team_users"
      end
      it 'is expected to render the least team_user' do
        response_body = JSON.parse response.body
        expect(response_body["team_user"]["id"]).to match TeamUser.last.id
      end
      it 'is expected to return status :found' do
        expect(response).to have_http_status :ok
      end
    end
    context "when user doesnt have pending team_user" do
      before :each do
        create(:team_user, user: @current_user, inviting_status: :confirmed)
        get "/team_users"
      end
      it 'is expected to return status :not_found' do
        expect(response).to have_http_status :not_found
      end
    end
  end

end
