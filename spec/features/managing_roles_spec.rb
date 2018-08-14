require 'rails_helper'

feature "Admins can manage a user's roles" do
  scenario "when assigning roles to an existing user" do
    user = create(:user)
    admin = create(:user, :admin)
    login_as(admin)
    ie = create(:project, name: "Internet Explorer")
    vim = create(:project, name: "vim")

    visit admin_user_path(user)
    click_link 'Edit User'
    select 'Viewer', from: 'Internet Explorer'
    select 'Manager', from: 'vim'
    click_button 'Update User'
    expect(page).to have_content "User has been updated"

    click_link user.email
    expect(page).to have_content "Internet Explorer: Viewer"
    expect(page).to have_content "vim: Manager"
  end

  scenario "when assigning roles to a new user" do
    login_as(create(:user, :admin))
    ie = create(:project, name: "Internet Explorer")
    vim = create(:project, name: "vim")

    visit new_admin_user_path
    fill_in 'Email', :with => 'newuser@ticketee.com'
    fill_in 'Password', :with => 'password'
    select 'Editor', from: 'Internet Explorer'
    click_button 'Create User'
    click_link 'newuser@ticketee.com'

    expect(page).to have_content "Internet Explorer: Editor"
    expect(page).not_to have_content "vim"
  end
end
