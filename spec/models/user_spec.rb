require 'rails_helper'

RSpec.describe User, type: :model do

  context 'create new user' do
    it 'is invalid when without name' do
      user = build(:user, name: '')
      expect(user).to be_invalid
    end
  end

end
