class Planning < ActiveRecord::Base
  belongs_to :shop
  belongs_to :user
  has_many :shifts
  has_many :users, through: :shifts
  STATUS = ["On going", "Déclared", "Confirmed"]
  validates :status, inclusion: { in: STATUS }
end
