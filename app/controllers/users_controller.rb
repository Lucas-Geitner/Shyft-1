class UsersController < ApplicationController
  before_action :set_shop, only: [:new, :show, :create, :total]
  before_action :set_user, only: [:show, :update, :destroy, :destroy_contract]
  before_action :set_shop_employees, only: [:new, :show, :total]
  before_action :set_employees_shifts, only: [:show, :total]

  def new
    @user = User.new
    @membership = Membership.new
    @ability = Ability.new
    @error = false
  end

  def show
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
    @membership = @user.memberships.build(role: params[:user][:membership][:role], shop: @shop)
    @abilities = []
    @shop.postes.each do |poste|
      unless params["poste" + poste.id.to_s].nil?
        ability = @user.abilities.build(poste: poste)
        @abilities << ability
      end
    end


    if @user.save
      @user.invite!(current_user)
      @membership.save
      @abilities.each { |ability| ability.save }
      redirect_to new_user_path
    else
      @error = true
      redirect_to new_user_path
    end

    # JS - ignore for the moment
    # if @user.valid? && @membership.valid? && @abilities.all? { |a| a.valid? }
      # respond_to do |format|
      #   format.html { redirect_to user_path(@user) }
      #   format.js
      # end
    # else

      # respond_to do |format|
      #   format.html { render users_path }
      #   format.js
      # end
    # end
  end

  def total

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

  private

  def user_params
    params.require(:user).permit(:email, :contract)
  end

  def set_user
    @user = User.find(params[:id])
  end

  def set_shop
    @shop = current_user.shops.first
  end

  def set_shop_employees
    hr_managers = []
    line_managers = []
    employees = []

    @shop.users.each do |user|
      case user.role
      when "HR Manager" then hr_managers << user
      when "Line Manager" then line_managers << user
      else employees << user
      end
    end

    @shop_employees = [hr_managers, line_managers, employees]
  end

  def set_employees_shifts
    @employees_shifts = Hash.new
    @shop_employees[2].each do |employee|
      employee_shifts = Hash.new
      employee.shifts.each do |shift|
        if shift.starts_at.strftime("%B") == Date.today.strftime("%B")
          start_time = shift.starts_at
          end_time = shift.ends_at
          date = start_time.strftime("%A, %b %d")
          shift_duration = (end_time - start_time) / 1.hour
          employee_shifts[date] = shift_duration
        end
      end
      @employees_shifts[employee] = employee_shifts
    end
  end

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :password, :contract, :role)
  end
end
