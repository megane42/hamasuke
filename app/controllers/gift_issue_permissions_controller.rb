class GiftIssuePermissionsController < ApplicationController
  def new
  end

  def index
    case params[:scope]
    when "issued"
      @gift_issue_permissions = GiftIssuePermission.eager_load(gift: :sms_sending).order(id: :desc).issued
      @issued_tab_active = "active"
    when "unissued"
      @gift_issue_permissions = GiftIssuePermission.eager_load(gift: :sms_sending).order(id: :desc).unissued
      @unissued_tab_active = "active"
    else
      @gift_issue_permissions = GiftIssuePermission.eager_load(gift: :sms_sending).order(id: :desc).all
      @all_tab_active = "active"
    end
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
