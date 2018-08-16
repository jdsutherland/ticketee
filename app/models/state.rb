# == Schema Information
#
# Table name: states
#
#  id    :integer          not null, primary key
#  name  :string
#  color :string
#

class State < ActiveRecord::Base
  def to_s
    name
  end
end
