# == Schema Information
#
# Table name: sms_sendings
#
#  id                       :bigint           not null, primary key
#  sent_at                  :datetime         not null
#  created_at               :datetime         not null
#  updated_at               :datetime         not null
#  gift_issue_permission_id :bigint           not null
#
# Indexes
#
#  index_sms_sendings_on_gift_issue_permission_id  (gift_issue_permission_id) UNIQUE
#  index_sms_sendings_on_sent_at                   (sent_at)
#
# Foreign Keys
#
#  fk_rails_...  (gift_issue_permission_id => gift_issue_permissions.id)
#
class SmsSending < ApplicationRecord
  belongs_to :gift_issue_permission
end
