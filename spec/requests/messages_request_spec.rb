require 'rails_helper'

RSpec.describe "Messages", type: :request do

  before :each do
    @current_user = create(:user)
    @team_owner = create(:user)
    create(:team, slug: 'nerv', owner: @team_owner)
    @group = create(:group, slug: 'angel', owner: @team_owner)
    sign_in @current_user
  end
  describe '#create message' do
    context 'when user doesnt belong to the group informed' do
      before :each do
        post "/messages", params: { message: { group_id: @group.id, body: 'Yo!' } }
      end
      it 'is expected to return :forbidden status' do
        expect(response).to have_http_status :forbidden
      end
    end
    context 'when user is member of the group informed' do
      before :each do
        create(:team_user, user: @current_user, inviting_status: :confirmed)
        post "/messages", params: { message: { group_id: @group.id, body: 'Yo!' } }
      end
      it 'is expected to return status :created' do
        expect(response).to have_http_status :created
      end
    end
  end

  describe '#index' do
    before :each do
      sign_in @current_user
      create(:message, group: @group, body: 'Yo!', user: @team_owner)
    end
    context 'when current user isnt a member of the team' do
      before :each do
        get "/messages?group=#{@group.id}"
      end
      it 'is expected to return status :forbidden' do
        expect(response).to have_http_status :forbidden
      end
    end
    context 'when user is memeber of the group' do
      before :each do
        create(:team_user, user: @current_user, inviting_status: :confirmed)
        get "/messages?group=#{@group.id}"
      end
      it 'is expected to return status :ok' do
        expect(response).to have_http_status :ok
      end
      it 'is expected to render a list whith all messages from the group' do
        response_body = JSON.parse response.body
        expect(response_body["messages"].size).to match 1
      end
    end
  end

end
