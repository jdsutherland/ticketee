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
#

class Ticket < ActiveRecord::Base
  belongs_to :project
  belongs_to :author, class_name: "User"

  has_many :comments, dependent: :destroy
  has_many :attachments, dependent: :destroy
  accepts_nested_attributes_for :attachments, reject_if: :all_blank

  validates :name, presence: true
  validates :description, presence: true, length: { minimum: 10 }
end
