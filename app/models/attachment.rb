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

class Attachment < ActiveRecord::Base
  belongs_to :ticket

  mount_uploader :file, AttachmentUploader
end
