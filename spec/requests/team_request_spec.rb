require 'rails_helper'

RSpec.describe "Teams", type: :request do

  describe "GET /index" do
    context 'when user is logged in' do
      it 'is expected to return :success' do
        user = create(:user)    ## uncomment if using FactoryBot
        sign_in user
        get '/'
        expect(response).to have_http_status :success
      end
    end
    context 'when user isnt logged in' do
      it 'is expected to return forbidden' do
        get '/'
        expect(response).to have_http_status :forbidden
      end
    end
  end

end
