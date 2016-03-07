class Shop < ActiveRecord::Base
  belongs_to :organisation
  has_many :memberships
  has_many :users, through: :memberships
  has_many :plannings
  has_many :shppostes
  has_many :postes, through: :shppostes

  validates :name, presence: true
end
