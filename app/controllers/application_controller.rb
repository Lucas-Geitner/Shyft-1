class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  before_action :set_shop_for_user, if: :user_signed_in?
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def set_shop_for_user
    @shop = current_user.shops.first
  end
end
