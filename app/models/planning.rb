class Planning < ActiveRecord::Base
  belongs_to :shop
  belongs_to :user
  has_many :declared_plannings, dependent: :destroy
  has_many :shifts, dependent: :destroy
  has_many :users, through: :shifts
  STATUS = ["Ongoing", "Declared", "Confirmed"]
  validates :status, inclusion: { in: STATUS }
end
