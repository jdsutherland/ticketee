# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string
#  last_sign_in_ip        :string
#  created_at             :datetime
#  updated_at             :datetime
#  admin                  :boolean          default(FALSE)
#  archived_at            :datetime
#

class User < ActiveRecord::Base
  has_many :comments
  has_many :tickets
  has_many :roles

  scope :excluding_archived, -> { where(archived_at: nil) }

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  def to_s
    "#{email} (#{admin? ? 'Admin' : 'User'})"
  end

  def archive
    update(archived_at: Time.now)
  end

  def active_for_authentication?
    super && !archived?
  end

  def inactive_message
    !archived? ? super : :archived
  end

  def role_on(project)
    roles.find_by(project_id: project).try(:name)
  end

  def generate_api_key
    self.update_column(:api_key, SecureRandom.hex(16))
  end

  private

  def archived?
    !archived_at.nil?
  end
end
