class ApplicationController < ActionController::Base
  before_action :authenticate_user!, except: :home
  before_action :set_shop_for_user, if: :user_signed_in?
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def set_shop_for_user
    @shop = current_user.shops.first
  end

  def find_today_planning
    if @plannings = Planning.where("start_date < ? AND end_date > ?", Date.today, Date.today) != ""
        redirect_to planning_path(planning)
    else
      @plannings = Planning.all
    end
  end
end


