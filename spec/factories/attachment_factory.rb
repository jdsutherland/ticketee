# == Schema Information
#
# Table name: attachments
#
#  id         :integer          not null, primary key
#  file       :string
#  ticket_id  :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

FactoryGirl.define do
  factory :attachment do
    transient do
      file_to_attach "spec/fixtures/speed.txt"
    end

    file { File.open file_to_attach }
  end
end

