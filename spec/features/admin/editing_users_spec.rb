require 'rails_helper'

feature "Admins can edit new users" do
  scenario "with valid details" do
    user = FactoryGirl.create(:user)
    login_as(FactoryGirl.create(:user, :admin))

    visit admin_user_path(user)
    click_link 'Edit User'
    fill_in 'Email', with: 'newguy@example.com'
    click_button 'Update User'

    expect(page).to have_content "User has been updated."
    expect(page).to have_content "newguy@example.com"
    expect(page).to_not have_content user.email
  end

  scenario "when toggling a user's admin ability" do
    user = FactoryGirl.create(:user)
    login_as(FactoryGirl.create(:user, :admin))

    visit admin_user_path(user)
    click_link 'Edit User'
    check 'Is an admin?'
    click_button 'Update User'

    expect(page).to have_content "User has been updated."
    expect(page).to have_content "#{user.email} (Admin)"
  end
end


