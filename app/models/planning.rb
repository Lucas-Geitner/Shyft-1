class Planning < ActiveRecord::Base
  STATUS = ["Ongoing", "Declared", "Confirmed"]

  belongs_to :shop
  belongs_to :user
  has_many :declared_plannings, dependent: :destroy
  has_many :shifts, dependent: :destroy
  has_many :users, through: :shifts

  validates :status, inclusion: { in: STATUS }
  validates :shop, :user, presence: true
end
