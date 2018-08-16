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

FactoryGirl.define do
  factory :ticket do
    name "Example ticket"
    description "An example ticket, nothing more"
  end
end

