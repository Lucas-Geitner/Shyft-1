class MembershipsController < ApplicationController
  def create
  end

  def archive_user
    membership = Membership.find_by_user_id_and_shop_id(params[:user_id], params[:shop_id])
    membership.update(archived_at: DateTime.now)
    redirect_to new_user_path
  end

  def retrieve_user
    membership = Membership.find_by_user_id_and_shop_id(params[:user_id], params[:shop_id])
    membership.update(archived_at: nil)
    redirect_to new_user_path
  end
end
