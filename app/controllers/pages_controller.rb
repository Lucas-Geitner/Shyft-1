class PagesController < ApplicationController
  layout "home_layout", only: :home
  def home
    redirect_to shop_plannings_path(@shop) if user_signed_in?
  end
end
