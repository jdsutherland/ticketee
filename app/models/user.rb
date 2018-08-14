class User < ActiveRecord::Base
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

  private

  def archived?
    !archived_at.nil?
  end
end
