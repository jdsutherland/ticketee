require 'rails_helper'

feature "Users can view tickets" do
  scenario "with valid attributes" do
    author = create(:user)
    login_as(author)

    neovim = create(:project, name: "neovim")
    create(:ticket, project: neovim, author: author,
                                name: 'Make the codebase better',
                                description: 'Refactor the monolith.')

    ie = create(:project, name: "ie")
    create(:ticket, project: ie, author: author,
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
