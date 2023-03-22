class GiftIssuePermissionsController < ApplicationController
  def new
  end

  def index
    @gift_issue_permissions = GiftIssuePermission.all
  end

  def import
    GiftIssuePermission.import_csv(params[:csv_file])
    redirect_to gift_issue_permissions_url
  end
end
