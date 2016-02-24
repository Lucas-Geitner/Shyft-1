class SchedulerTestController < ApplicationController
  def test
    @today = DateTime.new(2015, 2, 11)
    @start_time = 8
    @end_time = 4
    if @end_time < @start_time
      @range = (@start_time..23).to_a
      (0..@end_time).to_a.each { |t| @range << t }
    else
      @range = (@start_time..@end_time).to_a
    end
    @employees = ["Paul","John","Mark","Jack"]
    @postes = ["barista", "accueil", "cuisine", "service"]
    @shift = Shift.new()
    @planning = Planning.find(params[:planning_id])
  end
end
