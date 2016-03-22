class PostesController < ApplicationController
  before_action :set_org_postes, only: [:new, :create]
  before_action :set_shp_postes, only: [:new, :create]

  def new
    @shop_poste = ShopPoste.new
    @shop_postes = Hash.new
    @shp_postes.sort_by { |p| p.poste.name }.each do |shpposte|
      case shpposte.poste.name
      when "Cuisine" then logo = 'https://maxcdn.icons8.com/Color/PNG/96/Food/hamburger-96.png'
      when "Caisse" then logo = 'https://maxcdn.icons8.com/Color/PNG/96/Ecommerce/check-96.png'
      when "Plonge" then logo = 'https://maxcdn.icons8.com/Color/PNG/96/Household/broom-96.png'
      when "McCafe" then logo = 'https://maxcdn.icons8.com/Color/PNG/96/Food/coffee_to_go-96.png'
      when "Bar" then logo = 'https://maxcdn.icons8.com/Color/PNG/96/Food/coffee_to_go-96.png'
      when "Service" then logo = 'https://maxcdn.icons8.com/Color/PNG/96/Food/waiter-96.png'
      else logo = 'https://maxcdn.icons8.com/Color/PNG/96/City/restaurant-96.png'
      end
      @shop_postes[shpposte] = logo
    end
  end

  def create
    @org_postes.each do |orgposte|
      unless params["poste" + orgposte.id.to_s].nil?
        used_colors = ShopPoste.where(shop: @shop).pluck(:color)
        if used_colors.length < POSTE_COLORS.length
          new_color = (POSTE_COLORS - used_colors)[0]
        elsif used_colors.empty? || used_colors.length % POSTE_COLORS.length == 0
          new_color = POSTE_COLORS[0]
        else
          color_frequency = used_colors.uniq.map { |i| used_colors.count(i) }
          repeated_colors = []
          used_colors.uniq.each_with_index do |color, i|
            repeated_colors << color if color_frequency[i] == color_frequency.max
          end
          new_color = (POSTE_COLORS - repeated_colors)[0]
        end
        ShopPoste.create(
          shop: @shop,
          poste: orgposte.poste,
          color: new_color)
      end
    end
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
    poste = ShopPoste.find(params[:id])
    poste.destroy
    redirect_to(:back)
  end

  private

  def set_org_postes
    @org_postes = OrganisationPoste.where(organisation: @shop.organisation)
  end

  def set_shp_postes
    @shp_postes = ShopPoste.where(shop: @shop)
  end

  def poste_params
    params.require(:poste).permit(:name)
  end
end
