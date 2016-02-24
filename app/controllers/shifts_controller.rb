class ShiftsController < ApplicationController
  def create
    raise
    @planning = Planning.find(:planning_id)
    @shift = Shift.new()
    @shift.user = User.find_by_name(params[:user])
    @shift.planning = @planning
    @poste = Poste.find_by_name(params[:poste])
    @shift.poste = @poste
    raise
  end

  def update
  end

  def destroy
  end
end
