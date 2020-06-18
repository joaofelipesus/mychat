require 'rails_helper'

RSpec.describe "Teams", type: :request do

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
end
