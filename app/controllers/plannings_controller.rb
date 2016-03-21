require 'csv'

class PlanningsController < ApplicationController
  def index
    if params[:date] && params[:date] != ""
      @plannings_actuels = Planning.where("start_date <= ? AND end_date >= ? AND start_date <= ? AND end_date >= ? AND shop_id = ? ", params[:date], params[:date], Date.today, Date.today, params[:shop_id])
      @plannings_futures = Planning.where("start_date <= ? AND end_date >= ? AND start_date >= ?  AND shop_id = ? ", params[:date], params[:date], Date.today, params[:shop_id])
      @plannings_archives = Planning.where("start_date <= ? AND end_date >= ? AND end_date < ? AND shop_id = ? ", params[:date], params[:date], Date.today, params[:shop_id])
    else
      @plannings_actuels = Planning.where("start_date <= ? AND end_date >= ? AND shop_id = ? ", Date.today, Date.today, params[:shop_id])
      @plannings_futures = Planning.where("start_date >= ?  AND shop_id = ? ", Date.today, params[:shop_id])
      @plannings_archives = Planning.where("end_date < ? AND shop_id = ? ", Date.today, params[:shop_id])
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
    @start_month = DateTime.new(@today.year, @today.month)
    @end_month = @start_month + 1.month
    @employees = @shop.users
    @shift = Shift.new()

    @postes = Hash.new
    shop_postes = ShopPoste.where(shop: @shop)
    shop_postes.each do |shpposte|
      case shpposte.poste.name
      when "Cuisine" then logo = 'https://maxcdn.icons8.com/Color/PNG/96/Food/hamburger-96.png'
      when "Caisse" then logo = 'https://maxcdn.icons8.com/Color/PNG/96/Ecommerce/check-96.png'
      when "Plonge" then logo = 'https://maxcdn.icons8.com/Color/PNG/96/Household/broom-96.png'
      when "McCafe" then logo = 'https://maxcdn.icons8.com/Color/PNG/96/Food/coffee_to_go-96.png'
      when "Service" then logo = 'https://maxcdn.icons8.com/Color/PNG/96/Food/waiter-96.png'
      else logo = 'https://maxcdn.icons8.com/Color/PNG/96/City/restaurant-96.png'
      end
      @postes[shpposte] = logo
    end
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
    archived_planning = @planning.end_date < Time.now
    @planning.destroy
    if archived_planning == true
      redirect_to(shop_plannings_path(@shop, archives: true))
    else
      redirect_to(:back)
    end
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

  def declare
    @planning = Planning.find(params[:id])
    @planning.update(status: "Declared")
    declared_planning = DeclaredPlanning.new(planning: @planning)
    hash = {}
    @planning.shifts.each do |shift|
      parameters = {
        user: shift.user_id,
        poste: shift.poste_id,
        planning: shift.planning_id,
        starts_at: shift.starts_at,
        ends_at: shift.ends_at
      }
      hash[shift.id] = parameters
    end
    declared_planning.shifts = hash
    declared_planning.save
    send_data to_csv(@planning, declared_planning), filename: "planning#{@planning.id}.csv"
  end

  def export
    @planning = Planning.find(params[:id])
    declared_planning = DeclaredPlanning.find_by_planning_id(@planning.id)
    send_data to_csv(@planning, declared_planning), filename: "planning#{@planning.id}.csv"
  end

  private

  def to_csv(planning, declared_planning)
    CSV.generate do |csv|
      csv << ['Planning for ' + planning.start_date.strftime("%a, %e %b %Y") + ' - ' + planning.end_date.strftime("%a, %e %b %Y")]
      csv << ['User name', 'Poste', 'From', 'To']
      declared_planning["shifts"].sort_by { |k, v| DateTime.strptime(v["starts_at"], '%Y-%m-%dT%H:%M:%S.000Z') }.each do |shift|
        shift = shift[1]
        csv << [User.find(shift["user"]).name, Poste.find(shift["poste"]).name, shift["starts_at"], shift['ends_at']]
      end
    end
  end

  def planning_params
    params.require(:planning).permit(:name, :start_date, :end_date, :user_id, :shop_id, :status)
  end
end

# declared_planning["shifts"].sort_by { |k, v| DateTime.strptime(v["starts_at"], '%Y-%m-%dT%H:%M:%S.000Z') }

