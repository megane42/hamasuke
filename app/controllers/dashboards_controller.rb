class DashboardsController < ApplicationController
  def show
    @count_gift = Gift.count
    @sum_point  = Gift.sum :initial_point
  end
end
