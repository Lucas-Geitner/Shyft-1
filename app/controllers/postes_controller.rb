class PostesController < ApplicationController
  def new
    @poste = Shpposte.new
    @postes = Hash.new
    @shop.postes.sort_by { |p| p.name }.each do |poste|
      case poste.name
      when "Cuisine" then logo = 'https://maxcdn.icons8.com/Color/PNG/96/Food/hamburger-96.png'
      when "Caisse" then logo = 'https://maxcdn.icons8.com/Color/PNG/96/Ecommerce/check-96.png'
      when "Plonge" then logo = 'https://maxcdn.icons8.com/Color/PNG/96/Household/broom-96.png'
      when "McCafe" then logo = 'https://maxcdn.icons8.com/Color/PNG/96/Food/coffee_to_go-96.png'
      when "Service" then logo = 'https://maxcdn.icons8.com/Color/PNG/96/Food/waiter-96.png'
      else logo = 'https://maxcdn.icons8.com/Color/PNG/96/City/restaurant-96.png'
      end
      @postes[poste] = logo
    end
  end

  def create
    used_colors = Shpposte.where(shop: @shop).pluck(:color)
    available_colors = POSTE_COLORS - used_colors
    @poste = Shpposte.create(
      shop: @shop,
      poste_id: params[:shpposte][:poste],
      color: available_colors[0])
    redirect_to new_poste_path
  end

  def edit
    @poste = Poste.find(params[:id])
  end

  def update
    @poste = Poste.find(params[:id])
    @poste.update(name: params[:poste][:name])
    redirect_to new_poste_path
  end

  def destroy
    @poste = Shpposte.where(shop: @shop, poste_id: params[:id]).first
    @poste.destroy
    redirect_to(:back)
  end

  def poste_params
    params.require(:poste).permit(:name)
  end
end
