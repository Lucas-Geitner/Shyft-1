class PlanningsController < ApplicationController
  def index
    if params[:date] && params[:date] != ""
      @plannings = Planning.where("start_date < ? AND end_date > ? AND shop_id = ? AND status = ?", params[:date], params[:date], params[:shop_id], params[:status])
    else
      @plannings = Planning.where("shop_id = ?", params[:shop_id])
    end
    @planning = Planning.new
  end

  def new
    @planning = Planning.new
  end

  def show
    @planning = Planning.find(params[:id])
    @shop = @planning.shop
    @week = params[:week] ? params[:week].to_i : 1
    @day = params[:day] ? ((@week - 1) * 7) + params[:day].to_i : 1
    @today = params[:day] ? (@planning.start_date + (@day - 1).days) : @planning.start_date
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

  def create
    @planning = Planning.new(planning_params)
    @planning.user = current_user
    @planning.shop = @shop
    @planning.status = "Ongoing"
    @planning.save
    redirect_to planning_path(@planning)
  end

  def edit
    @planning = Planning.find(params[:id])
  end

  def update
    @planning = Planning.find(params[:id])
    @planning.update(planning_params)
  end

  def destroy
    @planning = Planning.find(params[:id])
    @planning.destroy
    redirect_to(:back)
  end

  def week_view
    @planning = Planning.find(params[:id])
    @week = params[:week] ? params[:week].to_i : 1
    @week_start = @planning.start_date + (7 * (@week - 1).days)
    @monday = @week_start
    until @monday.strftime("%A") == "Monday" do
      @monday = @monday - 1.days
    end
    @shop = @planning.shop
    @start_time = @shop.opening_time.hour
    @end_time = @shop.closing_time.hour
    if @end_time < @start_time
      @range = (@start_time..23).to_a
      (0..@end_time).to_a.each { |t| @range << t }
    else
      @range = (@start_time..@end_time).to_a
    end
  end

  private

  def planning_params
    params.require(:planning).permit(:name, :start_date, :end_date, :user_id, :shop_id, :status)
  end
end
