require 'rails_helper'

RSpec.describe "Groups", type: :request do

  before :each do
    @current_user = create(:user)
    create(:team, slug: 'nerv')
  end

  describe 'create' do
    context 'when user isnt logged in' do
      it 'is expected to return found status' do
        post '/groups', params: { group: { team_id: Team.last.id } }
        expect(response).to have_http_status :found
      end
    end
    context 'when user is logged in' do
      before :each do
        sign_in @current_user
      end
      context 'when group already have this slug' do
        before :each do
          create(:group, slug: 'evangelion')
          post '/groups', params: { group: { slug: 'evangelion', team_id: Team.last.id } }
        end
        it 'is expected to return :unprocessable_entity' do
          expect(response).to have_http_status :unprocessable_entity
        end
        it 'is expected to return error message Slug already in use' do
          response_body = JSON.parse response.body
          expect(response_body["errors"].first).to match "Slug has already been taken"
        end
      end
      context 'when slug is invaliid' do
        before :each do
          post '/groups', params: { group: { slug: '896123kjbsd###', team_id: Team.last.id } }
        end
        it 'is expected to return :unprocessable_entity' do
          expect(response).to have_http_status :unprocessable_entity
        end
        it 'is expected to return error message invalid pattern' do
          response_body = JSON.parse response.body
          expect(response_body["errors"].first).to match "Slug is invalid"
        end
      end
      context 'when slug is ok' do
        before :each do
          post '/groups', params: { group: {slug: 'asuka', team_id: Team.last.id } }
        end
        it 'is expected to return status :created' do
          expect(response).to have_http_status :created
        end
        it 'is expected to return group created' do
          response_body = JSON.parse response.body
          returned_group = response_body["group"]
          expect(returned_group["owner_id"]).to match @current_user.id
          expect(returned_group["slug"]).to match "asuka"
        end
      end
    end
  end

end
