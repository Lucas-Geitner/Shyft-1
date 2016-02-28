class Shop < ActiveRecord::Base
  belongs_to :organisation
  has_many :memberships
  has_many :users, through: :memberships
  has_many :plannings
  has_many :postes, -> { uniq }, through: :users
end
