require 'rails_helper'

describe TicketsController, type: :controller do
  it "can create tickets but not tag them" do
    user = create(:user)
    project = create(:project)
    sign_in user
    assign_role!(user, :editor, project)

    post :create, ticket: { name: "New ticket!",
                            description: 'Such a new ticket',
                            tag_names: "one two" },
                  project_id: project.id

    expect(Ticket.last.tags).to be_empty
  end
end
