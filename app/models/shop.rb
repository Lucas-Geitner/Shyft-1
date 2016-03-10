class Shop < ActiveRecord::Base
  belongs_to :organisation
  has_many :memberships
  has_many :users, through: :memberships
  has_many :plannings
  has_many :shop_postes
  has_many :postes, through: :shop_postes

  validates :name, presence: true
end
