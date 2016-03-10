class UsersController < ApplicationController
  before_action :set_user, only: [:show, :update, :destroy, :destroy_contract]
  before_action :set_shop_employees, only: [:new, :show, :total, :archives]

  def new
    @user = User.new
    @membership = Membership.new
    @ability = Ability.new
  end

  def show
    set_employees_shifts(Date.today)
    @similar_users = []
    unless @user.postes.empty?
      @user.abilities.each do |ability|
        @similar_users << @shop.users.joins(:abilities).where(abilities: {poste_id: ability.poste.id})
      end
      @similar_users = @similar_users.flatten.uniq.reject { |user| user == @user }
    end
  end

  def create
    @user = User.new(user_params)
    @user.start_date = params[:start_date]
    @membership = Membership.new(
      user: @user,
      shop: @shop,
      role: params[:user][:membership][:role])
    @abilities = []
    @shop.postes.each do |poste|
      unless params["poste" + poste.id.to_s].nil?
        ability = Ability.new(
          user: @user,
          poste: poste)
        @abilities << ability
      end
    end

    if @user.save
      @membership.save
      @abilities.each { |ability| ability.save }
      redirect_to new_user_path
    else
      redirect_to new_user_path
    end
  end

  def total
    @month = params[:month] ? params[:month].to_i : 0
    @today = Date.today + @month.months
    set_employees_shifts(@today)
  end

  def edit
  end

  def update
    @user.update(user_params)

    unless request.xhr?
      redirect_to user_path(@user)
    end
  end

  def destroy
    @user.destroy
    redirect_to new_user_path
  end

  def destroy_contract
    @user.contract.destroy
    respond_to do |format|
      format.html{}
      format.js
    end
  end

  def archives

  end

  private

  def user_params
    params.require(:user).permit(:email, :contract)
  end

  def set_user
    @user = User.find(params[:id])
  end

  def set_shop_employees
    hr_managers = []
    line_managers = []
    employees = []

    @shop.users.sort_by { |u| u.last_name.capitalize }.each do |user|
      case user.role
      when "HR Manager" then hr_managers << user
      when "Line Manager" then line_managers << user
      else employees << user
      end
    end

    @shop_employees = [hr_managers, line_managers, employees]
  end

  def set_employees_shifts(given_date)
    @employees_shifts = Hash.new
    @shop_employees[2].each do |employee|
      employee_shifts = Hash.new
      employee.shifts.each do |shift|
        if shift.starts_at.strftime("%B") == given_date.strftime("%B")
          start_time = shift.starts_at
          end_time = shift.ends_at
          date = french_days(start_time.strftime("%A")) + start_time.strftime(" %d ") + french_mn(start_time.strftime("%b"))
          shift_duration = (end_time - start_time) / 1.hour
          employee_shifts[date] = shift_duration
        end
      end
      @employees_shifts[employee] = employee_shifts
    end
  end

  def user_params
    params.require(:user).permit(
      :first_name,
      :last_name,
      :email,
      :password,
      :contract,
      :role,
      :phone,
      :start_date,
      :hourly_wage,
      :contract_hours)
  end

    def french_months(date)
    case date
      when "January" then "janvier"
      when "February" then "février"
      when "March" then "mars"
      when "April" then "avril"
      when "May" then "mai"
      when "June" then "juin"
      when "July" then "juillet"
      when "August" then "août"
      when "September" then "septembre"
      when "October" then "octobre"
      when "November" then "novembre"
      when "December" then "décembre"
      else date
    end
  end

  def french_mn(date)
    case date
      when "Jan" then "jan"
      when "Feb" then "fev"
      when "Mar" then "mar"
      when "Apr" then "avr"
      when "May" then "mai"
      when "Jun" then "juin"
      when "Jul" then "juil"
      when "Aug" then "août"
      when "Sep" then "sep"
      when "Oct" then "oct"
      when "Nov" then "nov"
      when "Dec" then "déc"
      else date
    end
  end

  def french_days(date)
    case date
      when "Monday" then "Lundi"
      when "Tuesday" then "Mardi"
      when "Wednesday" then "Mercredi"
      when "Thursday" then "Jeudi"
      when "Friday" then "Vendredi"
      when "Saturday" then "Samedi"
      when "Sunday" then "Dimanche"
      else date
    end
  end
end
