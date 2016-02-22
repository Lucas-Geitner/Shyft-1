class SchedulerTestController < ApplicationController
  def test
    @start_time = 1
    @end_time = 20
    @range = (@start_time..@end_time).to_a
    @employees = ["Paul","Jean","Marc","Etienne"]
  end
end
