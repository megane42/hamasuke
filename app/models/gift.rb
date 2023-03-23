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

  def issue
    # request(issue_identity: gift_issue_permission.survey_response_uid)
    self.url           = "https://example.com/#{SecureRandom.hex}"
    self.expired_at    = "2023-01-01 12:34:56"
    self.initial_point = gift_issue_permission.point
    save
  end
end
