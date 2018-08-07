require 'rails_helper'

feature "Users can view tickets" do
  scenario "with valid attributes" do
    neovim = FactoryGirl.create(:project, name: "neovim")
    FactoryGirl.create(:ticket, project: neovim,
                                name: 'Make the codebase better',
                                description: 'Refactor the monolith.')

    ie = FactoryGirl.create(:project, name: "ie")
    FactoryGirl.create(:ticket, project: ie,
                                name: "Standards compliance",
                                description: "Isn't a joke.")

    visit '/'
    click_link "neovim"
    expect(page).to have_content "Make the codebase better"
    expect(page).to_not have_content "Standards compliance"

    click_link 'Make the codebase better'
    # FIXME: hardcoding css sel bad - testing what user sees (care abt content)
    within('#ticket h2') do
      expect(page).to have_content "Make the codebase better"
    end
    expect(page).to have_content "Refactor the monolith."
  end
end
