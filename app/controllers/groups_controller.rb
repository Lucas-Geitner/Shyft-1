class GroupsController < ApplicationController
  def index
    @organisation = Organisation.find(params[:organisation_id])
  end

  def admin_space
  end

  def plannings
    @group = Group.find(params[:id])
    @organisation = @group.organisation
    now = DateTime.now
    @today = params[:date] ? DateTime.parse(params[:date]) : DateTime.new(now.year, now.month, now.day)
    @tomorrow = @today + 1.day
  end
end
