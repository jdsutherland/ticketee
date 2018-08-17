require 'rails_helper'

describe CommentsController, type: :controller do
  context "a user without permission to set state" do
    it "cannot transition a state by passing through state_id" do
      user = create(:user)
      sign_in user
      project = Project.create!(name: "Ticketee")
      assign_role!(user, :editor, project)
      state = State.create!(name: 'Hacked!')
      ticket = project.tickets.create(name: "State transitions",
                                      description: "Can't be hacked.", author: user)

      post :create, comment: { text: "Did I hack it??", state_id: state.id },
                    ticket_id: ticket.id
      ticket.reload

      expect(ticket.state).to be_nil
    end
  end

  context "a user without permission to tag a ticket" do
    it "cannot tag a ticket when creating a comment" do
      user = create(:user)
      sign_in user
      project = Project.create!(name: "Ticketee")
      assign_role!(user, :editor, project)
      ticket = project.tickets.create(name: "Tagging",
                                      description: "Can't be tagged.", author: user)

      post :create, comment: { text: "Tag!", tag_names: "one two" },
                    ticket_id: ticket.id
      ticket.reload

      expect(ticket.tags).to be_empty
    end
  end
end
