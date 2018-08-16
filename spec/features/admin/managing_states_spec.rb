require 'rails_helper'

feature "Admins can manage states" do
  scenario "and mark a state as default" do
    login_as(create(:user, :admin))
    state = create(:state, name: 'New')

    visit admin_states_path
    within list_item('New') do
      click_link 'Make Default'
    end

    expect(page).to have_content "'New' is now the default state."
  end
end


