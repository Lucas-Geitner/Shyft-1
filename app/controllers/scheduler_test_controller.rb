class SchedulerTestController < ApplicationController
  def test
    @planning = Planning.find(params[:planning_id])
    @shop = @planning.shop
    @today = @planning.start_date
    @start_time = @shop.opening_time.hour
    @end_time = @shop.closing_time.hour
    if @end_time < @start_time
      @range = (@start_time..23).to_a
      (0..@end_time).to_a.each { |t| @range << t }
    else
      @range = (@start_time..@end_time).to_a
    end
    @employees = @shop.users
    @postes = Poste.all
    @shift = Shift.new()
  end
end
