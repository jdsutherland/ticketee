# == Schema Information
#
# Table name: states
#
#  id    :integer          not null, primary key
#  name  :string
#  color :string
#

class State < ActiveRecord::Base
  def self.default
    find_by(default: true)
  end

  def to_s
    name
  end

  def make_default!
    State.update_all(default: false)
    update!(default: true)
  end
end
