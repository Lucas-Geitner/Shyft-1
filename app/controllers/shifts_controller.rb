class ShiftsController < ApplicationController
  def create
    @planning = Planning.find(params[:planning_id])
    @shift = Shift.new(shift_params)
    @shift.user = User.find(params[:shift][:user])
    @shift.planning = @planning
    @poste = Poste.find_by_name(params[:shift][:poste])
    @shift.poste = @poste
    @shift.save
  end

  def find_and_destroy
    @example = Shift.new(shift_params)
    @shift = Shift.find_by_user_id_and_starts_at(params[:shift][:user], @example.starts_at)
    @shift.destroy
  end

  def find_and_update
    @example = Shift.new(shift_params)
    @shift = Shift.find_by_user_id_and_starts_at(params[:shift][:user], @example.starts_at)
    @shift.update(ends_at: @example.ends_at)
  end

  private

  def shift_params
    params.require(:shift).permit(:starts_at, :ends_at)
  end
end
