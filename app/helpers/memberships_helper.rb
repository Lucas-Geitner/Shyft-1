module MembershipsHelper
  def find_membership(user, shop)
    return Membership.find_by_user_id_and_shop_id(user, shop)
  end
end
