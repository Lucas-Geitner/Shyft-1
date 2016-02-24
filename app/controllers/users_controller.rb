class UsersController < ApplicationController
  def new
    @user = User.new
    @membership = Membership.new
    @ability = Ability.new

    #TEMPORARY!!
    @shop = Shop.first
    @shop_employees = User.joins(:memberships).where(memberships: {shop_id: 1})
  end

  def show
    @user = User.find(params[:id])
  end

  def create
    @user = User.new(user_params)

    @shop = Shop.first

    @membership = @user.memberships.build(role: params[:user][:membership][:role], shop: @shop)
    @abilities = []
    params[:user][:ability][:poste].reject(&:empty?).each do |i|
      ability = @user.abilities.build(poste_id: i.to_i)
      @abilities << ability
    end

    if @user.valid? && @membership.valid? && @abilities.all? { |a| a.valid? }
      @user.save
      @membership.save
      @abilities.each { |ability| ability.save }
      respond_to do |format|
        format.html { redirect_to user_path(@user) }
        format.js
      end
    else
      respond_to do |format|
        format.html { render users_path }
        format.js
      end
    end
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :password, :contract)
  end
end
