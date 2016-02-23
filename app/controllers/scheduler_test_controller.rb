class SchedulerTestController < ApplicationController
  def test
    @start_time = 8
    @end_time = 4
    if @end_time < @start_time
      @range = (@start_time..23).to_a
      (0..@end_time).to_a.each { |t| @range << t }
    else
      @range = (@start_time..@end_time).to_a
    end
    @employees = ["Paul","Jean","Marc","Etienne"]
    @postes = ["barista", "accueil", "cuisine", "service"]
  end
end
