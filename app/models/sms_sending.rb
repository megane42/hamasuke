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

  def self.send_sms!(gift_issue_permission:)
    return nil if gift_issue_permission.sms_sending.present?

    client = AccreteApiClient.new
    client.send_short_message!(
      text:  text(gift_issue_permission: gift_issue_permission),
      telno: gift_issue_permission.telephone
    )

    self.create!(
      gift_issue_permission: gift_issue_permission,
      sent_at:               Time.zone.now
    )
  end

  private

  def self.text(gift_issue_permission:)
    <<~EOS
      この度は、福島省エネ家電購入応援キャンペーンにご応募いただきありがとうございます。
      申請内容の審査が完了しましたので、下記URLからキャッシュレスポイント受け取りの手続きを進めていただくようお願いいたします。

      回答番号：#{gift_issue_permission.survey_response_uid}
      製品種別：#{gift_issue_permission.product_category_name}
      購入店舗：#{gift_issue_permission.store_name}

      #{gift_issue_permission.gift_url}

      ※「えらべるPay」のポイントには有効期限がありますので、お早めに各種キャッシュレスポイントへの交換を行ってください。
      ※ポイント交換レートはキャッシュレスポイントの種類によって異なります。

      --
      お客様コールセンター
      TEL：0120-661-044
      受付時間：10時～20時（土日祝日含む）
    EOS
  end
end
