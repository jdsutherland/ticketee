# == Schema Information
#
# Table name: states
#
#  id      :integer          not null, primary key
#  name    :string
#  color   :string
#  default :boolean          default(FALSE)
#

FactoryGirl.define do
  factory :state do
    name "A state"
  end
end

