# == Schema Information
#
# Table name: sms_sendings
#
#  id         :bigint           not null, primary key
#  sent_at    :datetime         not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  gift_id    :bigint           not null
#
# Indexes
#
#  index_sms_sendings_on_gift_id  (gift_id) UNIQUE
#  index_sms_sendings_on_sent_at  (sent_at)
#
# Foreign Keys
#
#  fk_rails_...  (gift_id => gifts.id)
#
class SmsSending < ApplicationRecord
  belongs_to :gift

  def self.send_sms!(gift:)
    return nil if gift.sms_sending.present?

    client = AccreteApiClient.new
    client.send_short_message!(text: text_for(gift), telno: gift.telephone)

    self.create!(gift: gift, sent_at: Time.zone.now)
  end

  private

  def self.text_for(gift)
    <<~EOS
      この度は、福島省エネ家電購入応援キャンペーンにご応募いただきありがとうございます。
      申請内容の審査が完了しましたので、下記URLからキャッシュレスポイント受け取りの手続きを進めていただくようお願いいたします。

      回答番号：#{gift.survey_response_uid}
      製品種別：#{gift.product_category_name}
      購入店舗：#{gift.store_name}

      #{gift.url}

      ※「えらべるPay」のポイントには有効期限がありますので、お早めに各種キャッシュレスポイントへの交換を行ってください。
      ※ポイント交換レートはキャッシュレスポイントの種類によって異なります。

      --
      お客様コールセンター
      TEL：0120-661-044
      受付時間：10時～20時（土日祝日含む）
    EOS
  end
end
