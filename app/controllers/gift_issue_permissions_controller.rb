class GiftIssuePermissionsController < ApplicationController
  def new
  end

  def import
    GiftIssuePermission.import_csv!(params[:csv_file])
    redirect_to new_gift_issue_permission_url
  end
end
