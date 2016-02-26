class UsersController < ApplicationController
  def new
    @user = User.new
    @membership = Membership.new
    @ability = Ability.new
    @shop = current_user.shops.first
    @shop_employees = @shop.users
  end

  def show
    @user = User.find(params[:id])
  end

  def create
    @user = User.new(user_params)
    @shop = current_user.shops.first
    @membership = @user.memberships.build(role: params[:role], shop: @shop)
    @abilities = []
    params[:user][:postes].reject(&:empty?).each do |i|
      ability = @user.abilities.build(poste_id: i.to_i)
      @abilities << ability
    end

    # if @user.valid? && @membership.valid? && @abilities.all? { |a| a.valid? }
    if @user.save
      raise
      @user.invite!(current_user)
      @membership.save
      @abilities.each { |ability| ability.save }
      redirect_to new_user
    else
      raise
      redirect_to :back
    end
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
