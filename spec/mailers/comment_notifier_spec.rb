require "rails_helper"

describe CommentNotifier, type: :mailer do
  describe '#created' do
    it "delivers an email notification about a new comment" do
      project = create(:project)
      ticket_owner = create(:user)
      ticket = create(:ticket, project: project, author: ticket_owner)
      commenter = create(:user)
      comment = Comment.new(ticket: ticket, author: commenter,
                            text: 'Test comment')

      email = CommentNotifier.created(comment, ticket_owner)

      expect(email.to).to include ticket_owner.email
      title = "#{ticket.name} for #{project.name} has been updated."
      expect(email.body.to_s).to include title
      expect(email.body.to_s).to include "#{commenter.email} wrote:"
      expect(email.body.to_s).to include comment.text
    end
  end
end
