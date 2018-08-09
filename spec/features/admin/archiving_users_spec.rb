require 'rails_helper'

feature "Admins can archive users" do
  scenario "successfully" do
    user = create(:user)
    login_as(create(:user, :admin))

    visit admin_user_path(user)
    click_link 'Archive User'

    expect(page).to have_content "User has been archived."
    expect(page).to_not have_content user.email
  end

  scenario "but cannot archive themselves" do
    admin = create(:user, :admin)
    login_as(admin)

    visit admin_user_path(admin)
    click_link 'Archive User'

    expect(page).to have_content "You cannot archive yourself!"
  end
end
