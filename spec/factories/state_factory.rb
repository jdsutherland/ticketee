# == Schema Information
#
# Table name: states
#
#  id    :integer          not null, primary key
#  name  :string
#  color :string
#

FactoryGirl.define do
  factory :state do
    name "A state"
  end
end

