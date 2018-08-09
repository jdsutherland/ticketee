require 'rails_helper'

feature "Users can sign out" do
  scenario do
    user = create(:user)
    login_as(user)

    visit '/'
    click_link 'Sign out'

    expect(page).to have_content "Signed out successfully"
  end
end


