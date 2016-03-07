class Organisation < ActiveRecord::Base
  has_many :organisation_memberships
  has_many :shops
  has_many :orgpostes
  has_many :postes, through: :orgpostes
end
