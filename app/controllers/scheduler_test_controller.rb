class SchedulerTestController < ApplicationController
  def test
    @today = DateTime.new(2000, 6, 5)
    @start_time = 8
    @end_time = 4
    if @end_time < @start_time
      @range = (@start_time..23).to_a
      (0..@end_time).to_a.each { |t| @range << t }
    else
      @range = (@start_time..@end_time).to_a
    end
    @employees = %w(Jesse Sister Andreane Kenneth)
    @postes = %w(kitchen cashier bar dishwash)
    @shift = Shift.new()
    @planning = Planning.find(params[:planning_id])
  end
end
