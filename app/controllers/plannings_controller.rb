class PlanningsController < ApplicationController
  def index
    @plannings = Planning.all
  end

  def new
    @planning = Plannnig.new
  end

  def create
    @planning = planning.new(planning_params)
    @planning.save
    redirect_to planning_path(@planning)
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
