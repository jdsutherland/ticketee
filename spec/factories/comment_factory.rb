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

FactoryGirl.define do
  factory :comment do
    text { "A comment describing some changes that should be made to this ticket." }
  end
end

