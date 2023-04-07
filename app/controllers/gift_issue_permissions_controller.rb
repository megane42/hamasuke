class GiftIssuePermissionsController < ApplicationController
  def new
  end

  def index
    @q = GiftIssuePermission.ransack(params[:q])
    @gift_issue_permissions = @q.result.eager_load(gift: :sms_sending).page(params[:page])
  end

  def import
    GiftIssuePermission.import_csv(params[:csv_file])
    flash[:success] = "インポートが完了しました。"
    redirect_to gift_issue_permissions_url
  end

  def issue
    GiftIssuePermission.unissued.find_each do |gift_issue_permission|
      IssueGiftAndSendSmsJob.perform_async(gift_issue_permission.id)
    end
    flash[:success] = "ギフト発行処理を開始しました。少し待ってからリロードしてください。"
    redirect_to gift_issue_permissions_url
  end
end
