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

  def after_invite_path_for(resource)
    @user.update(user_params)
    @user.start_date = params[:start_date]
    @membership = Membership.new(
      user: @user,
      shop: @shop,
      role: params[:user][:membership][:role],
      contract_hours: params[:user][:membership][:contract_hours])
    @abilities = []
    @shop.postes.each do |poste|
      unless params["poste" + poste.id.to_s].nil?
        ability = Ability.new(
          user: @user,
          poste: poste)
        @abilities << ability
      end
    end
    @membership.save
    @abilities.each { |ability| ability.save }
    new_user_path
  end

  def user_params
    params.require(:user).permit(
      :first_name,
      :last_name,
      :email,
      :contract,
      :role,
      :phone,
      :start_date,
      :hourly_wage)
  end
end


