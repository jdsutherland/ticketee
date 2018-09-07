# require 'rails_helper'

# describe CommentCreator do
#   describe '#self.build' do
#     it "builds a comment" do
#       user = create(:user)
#       ticket = create(:ticket, project: create(:project), author: user)
#       comment = double(:comment)
#       scope = ticket.comments
#       allow(scope).to receive(:build).and_return(comment)
#       allow(comment).to receive(:author=)
#       creator = CommentCreator.build(scope, user, {})

#       # TODO how to properly test this
#       expect(creator.comment).to eq comment
#     end
#   end

#   describe '#save' do
#     it "notifies watchers" do
#       comment = double(:comment)
#       comment_creator = double(:comment_creator)
#       allow(comment_creator).to receive(:comment=)
#       comment_creator.comment = comment
#       allow(comment).to receive(:save)

#       comment.save

#       # TODO how to properly test this
#       # expect(comment_creator).to receive(:notify_watchers)
#     end
#   end
# end
