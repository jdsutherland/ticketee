# == Schema Information
#
# Table name: tickets
#
#  id          :integer          not null, primary key
#  name        :string
#  description :text
#  project_id  :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  author_id   :integer
#  state_id    :integer
#

class Ticket < ActiveRecord::Base
  belongs_to :author, class_name: "User"
  belongs_to :project
  belongs_to :state

  has_and_belongs_to_many :tags, uniq: true

  has_many :comments, dependent: :destroy
  has_many :attachments, dependent: :destroy
  accepts_nested_attributes_for :attachments, reject_if: :all_blank

  validates :name, presence: true
  validates :description, presence: true, length: { minimum: 10 }

  before_create :assign_default_state

  attr_accessor :tag_names

  searcher do
    label :tag, from: :tags, field: "name"
  end

  def tag_names=(names)
    @tag_names = names
    names.split.each do |name|
      tags << Tag.find_or_initialize_by(name: name)
    end
  end

  private

  def assign_default_state
    self.state ||= State.default
  end
end
