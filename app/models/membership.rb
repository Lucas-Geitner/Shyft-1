class Membership < ActiveRecord::Base
  belongs_to :user
  belongs_to :shop
  ROLES = ["Line Manager", "RH Manager", "Basic Employee"]
end
