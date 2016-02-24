class UsersController < ApplicationController
  def new
    @user = User.new
    @membership = Membership.new
    @ability = Ability.new
    @shop_employees = User.joins(:memberships).where(memberships: {shop_id: 1})
  end

  def show
  end

  def create
    @user = User.new(user_params)
    Membership.create(
      user: @user,
      role: params[:user][:membership][:role])
    postes = []
    params[:user][:ability][:poste].reject(&:empty?).each do |i|
      postes << Poste.all.pluck("name")[i.to_i - 1]
    end
    postes.each do |poste|
      Ability.create(
        user: @user,
        poste: Poste.find_by_name(poste))
    end

    if @user.save
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
    params.require(:user).permit(:first_name, :last_name, :email, :password)
  end
end
