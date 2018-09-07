# == Schema Information
#
# Table name: comments
#
#  id                :integer          not null, primary key
#  text              :string
#  ticket_id         :integer
#  author_id         :integer
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  state_id          :integer
#  previous_state_id :integer
#

class Comment < ActiveRecord::Base
  belongs_to :author, class_name: "User"
  belongs_to :state
  belongs_to :previous_state, class_name: "State"
  belongs_to :ticket

  validates :text, presence: true

  delegate :project, to: :ticket

  scope :persisted, -> { where.not(id: nil) }

  before_create :set_previous_state
  after_create :set_ticket_state
  after_create :associate_tags_with_ticket
  after_create :author_watches_ticket

  attr_accessor :tag_names

  private

  def set_previous_state
    self.previous_state = ticket.state
  end

  def set_ticket_state
    ticket.state = state
    ticket.save!
  end

  def associate_tags_with_ticket
    if tag_names
      tag_names.split.each do |name|
        ticket.tags << Tag.find_or_initialize_by(name: name)
      end
    end
  end

  def author_watches_ticket
    if author.present? && !ticket.watchers.include?(author)
      ticket.watchers << author
    end
  end
end
