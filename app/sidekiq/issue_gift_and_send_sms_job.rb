class IssueGiftAndSendSmsJob
  include Sidekiq::Job
  include Sidekiq::Throttled::Worker

  sidekiq_throttle(
    threshold: { :limit => 2, :period => 1.second }
  )

  def perform(gift_issue_permission_id)
    gift_issue_permission = GiftIssuePermission.find(gift_issue_permission_id)
    ActiveRecord::Base.transaction do
      gift_issue_permission.lock!
      gift_issue_permission.issue_gift!
      gift_issue_permission.send_sms!
    end
  end
end
