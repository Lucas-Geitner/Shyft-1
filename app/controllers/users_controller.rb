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
      raise
      redirect_to :back
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

  def edit
  end

  def update
  end

  def destroy
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :password, :contract, :role)
  end
end
