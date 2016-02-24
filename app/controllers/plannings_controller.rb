class PlanningsController < ApplicationController
  def index
    @plannings = Planning.all
    @planning = Planning.new
    # @shop = current_user.shops.first
  end

  def new
    @planning = Planning.new
  end

  def create
    @planning = Planning.new(planning_params)
    @planning.save
    redirect_to planning_path(@shop, @planning)
  end

  def edit
    @planning = planning.find(params[:id])
  end

  def update
    @planning = planning.find(params[:id])
  end

  def destroy
    @planning = planning.find(params[:id])
    @planning.destroy
    redirect_to(:back)
  end

  def planning_params
    params.require(:planning).permit(:name, :start_date, :end_date, :user_id, :shop_id)
  end
end
