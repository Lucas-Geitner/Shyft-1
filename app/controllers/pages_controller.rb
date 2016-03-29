class PagesController < ApplicationController
  layout "home_layout", only: :home
  def home
    if user_signed_in?
      if @role == "Line Manager"
        redirect_to shop_plannings_path(@shop) if @role = "Line Manager"
      elsif @role == "HR Manager"
        redirect_to organisation_groups_path(@shop.organisation) if @role = "HR Manager"
      end
    end
  end
end
