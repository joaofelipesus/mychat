require 'rails_helper'

RSpec.describe "Teams", type: :request do

=begin
  describe "GET /index" do
    context 'when user is logged in' do
      it 'is expected to return :success' do
        user = create(:user)
        sign_in user
        get '/'
        expect(response).to have_http_status :success
      end
    end
  end

  describe 'POST /teams' do
    context 'when user are logged in' do
      before :each do
        @current_user = create(:user)
        sign_in @current_user
      end
      context 'when slug is already in use' do
        before :each do
          create(:team, slug: 'nerv')
          post '/teams', params: { team: { slug: 'nerv'} }
        end
        it 'is expected to return :unprocessable_entity' do
          expect(response).to have_http_status :unprocessable_entity
        end
        it 'is expected to return "Slug already in use"' do
          response_body = JSON.parse response.body
          expect(response_body["errors"]).to match ["Slug has already been taken"]
        end
      end
      context 'when params are ok' do
        before :each do
          post '/teams', params: { team: { slug: 'zelda' } }
        end
        it 'is expected to return status :created' do
          expect(response).to have_http_status :created
        end
        it 'is expected to return the team created' do
          response_body = JSON.parse response.body
          team = response_body["team"]
          expect(team["slug"]).to match "zelda"
          expect(team["owner_id"]).to match @current_user.id
        end
      end
    end
    context 'when user isnt logged in' do
      it 'is expected to return forbidden' do
        post '/teams', params: { team: { slug: 'asuka' }}
        expect(response).to have_http_status :found
      end
    end
  end
=end
  describe 'DELETE a team' do
    context 'when user are logged in' do
      before :each do
        @current_user = create(:user)
        sign_in @current_user
      end
      context 'when user isnt team owner' do
        before :each do
          other_user = create(:user)
          other_team = create(:team, slug: 'ocarina')
          create(:team_user, team: other_team, user: @current_user)
          delete "/teams/#{other_team.id}"
        end
        it 'is expeected to return :forbidden' do
          expect(response).to have_http_status :forbidden
        end
      end
      context 'when user is team owner' do
        before :each do
          @team = create(:team, owner: @current_user)
          delete "/teams/#{@team.id}"
        end
        it 'is expected to render :ok' do
          expect(response).to have_http_status :ok
        end
        it 'is expected to destroy team and its teams' do
          expect(Team.where(id: @team.id).empty?).to be_truthy
          expect(@current_user.reload.my_teams.empty?).to be_truthy
        end
      end
    end
    context 'when user arent logged in' do
      before :each do
        create(:user)
        team = create(:team)
        delete "/teams/#{team.id}"
      end
      it 'is expected to receive :found' do
        expect(response).to have_http_status :found
      end
    end
  end

end
