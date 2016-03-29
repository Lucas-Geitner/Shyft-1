class PrimesController < ApplicationController
  def new
    @prime = Prime.new
    @user = User.find(params[:user_id])
    @shop = Shop.find(params[:shop_id])
  end

  def create
    @prime = Prime.new(prime_params)
    @prime.for_month = DateTime.new(DateTime.now.year, params[:prime][:for_month].to_i)
    @prime.shop = Shop.find(params[:prime][:shop])
    @prime.user = User.find(params[:prime][:user])
    if @prime.save
      redirect_to admin_space_path(@prime.shop.group)
    else
      redirect_to :back
    end
  end

  private

  def prime_params
    params.require(:prime).permit(:amount, :description)
  end
end
