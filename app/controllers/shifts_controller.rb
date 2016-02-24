class ShiftsController < ApplicationController
  def create
    @planning = Planning.find(params[:planning_id])
    @shift = Shift.new(shift_params)
    @shift.user = User.find_by_first_name(params[:shift][:user])
    @shift.planning = @planning
    @poste = Poste.find_by_name(params[:shift][:poste])
    @shift.poste = @poste
    @shift.save
  end

  def find_and_destroy
    @example = Shift.new(shift_params)
    @shift = Shift.find_by_planning_id_and_starts_at(params[:planning_id], @example.starts_at)
    raise
  end

  def update
  end

  def destroy
  end

  private

  def shift_params
    params.require(:shift).permit(:starts_at, :ends_at)
  end
end
