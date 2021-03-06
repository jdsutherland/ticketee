require 'rails_helper'

feature "Users can sign in" do
  scenario 'when providing valid details' do
    user = create(:user)

    visit '/'
    click_link 'Sign in'
    fill_in 'Email', with: user.email
    fill_in 'user_password', with: 'password'
    click_button 'Sign in'

    expect(page).to have_content "Signed in successfully"
    expect(page).to have_content "Signed in as #{user.email}"
  end

  scenario 'unless they are archived' do
    user = create(:user)
    user.archive

    visit '/'
    click_link 'Sign in'
    fill_in 'Email', with: user.email
    fill_in 'user_password', with: 'password'
    click_button 'Sign in'

    expect(page).to have_content "Your account has been archived."
  end
end

