class GiftIssuePermissionsController < ApplicationController
  def new
  end

  def index
    @gift_issue_permissions = GiftIssuePermission.eager_load(:gift, :sms_sending).all
  end

  def import
    GiftIssuePermission.import_csv(params[:csv_file])
    redirect_to gift_issue_permissions_url
  end

  def issue
    GiftIssuePermission.unissued.unsent.find_each do |gift_issue_permission|
      IssueGiftAndSendSmsJob.perform_async(gift_issue_permission.id)
    end
    redirect_to gift_issue_permissions_url
  end
end
