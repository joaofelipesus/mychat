require 'rails_helper'

RSpec.describe "Messages", type: :request do

  describe '#create message' do
    before :each do
      @current_user = create(:user)
      team_owner = create(:user)
      create(:team, slug: 'nerv', owner: team_owner)
      @group = create(:group, slug: 'angel', owner: team_owner)
      sign_in @current_user
    end
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

end
