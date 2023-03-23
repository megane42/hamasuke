# == Schema Information
#
# Table name: gifts
#
#  id                       :bigint           not null, primary key
#  expired_at               :datetime         not null
#  initial_point            :integer          not null
#  url                      :string(255)      not null
#  created_at               :datetime         not null
#  updated_at               :datetime         not null
#  gift_issue_permission_id :bigint           not null
#
# Indexes
#
#  index_gifts_on_expired_at                (expired_at)
#  index_gifts_on_gift_issue_permission_id  (gift_issue_permission_id) UNIQUE
#  index_gifts_on_initial_point             (initial_point)
#  index_gifts_on_url                       (url) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (gift_issue_permission_id => gift_issue_permissions.id)
#
class Gift < ApplicationRecord
  belongs_to :gift_issue_permission
  has_one    :sms_sending, dependent: :destroy

  delegate :telephone,             to: :gift_issue_permission
  delegate :survey_response_uid,   to: :gift_issue_permission
  delegate :product_category_name, to: :gift_issue_permission
  delegate :store_name,            to: :gift_issue_permission
  delegate :sent_at,               to: :sms_sending, prefix: true, allow_nil: true

  def self.issue!(gift_issue_permission:)
    return nil if gift_issue_permission.gift.present?

    client = Ikedayama::Client.new
    giftee_box = client.create_giftee_box(
      giftee_box_config_code: ENV["IKEDAYAMA_GIFTEE_BOX_CONFIG_CODE"],
      issue_identity: gift_issue_permission.survey_response_uid,
      initial_point:  gift_issue_permission.point,
    )

    self.create!(
      gift_issue_permission: gift_issue_permission,
      url:                   giftee_box.url,
      expired_at:            giftee_box.expired_at,
      initial_point:         giftee_box.initial_point,
    )
  end

  def send_sms!
    SmsSending.send_sms!(gift: self)
  end
end
