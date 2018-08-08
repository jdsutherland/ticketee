require 'rails_helper'

RSpec.describe Admin::ApplicationController, type: :controller do
  user = FactoryGirl.create(:user)

  context 'non-admin users' do
    it 'are not able to access the index action' do
      allow(controller).to receive(:authenticate_user!)
      allow(controller).to receive(:current_user).and_return(user)

      get :index

      expect(response).to redirect_to '/'
      expect(flash[:alert]).to eq "You must be an admin to do that."
    end
  end
end
