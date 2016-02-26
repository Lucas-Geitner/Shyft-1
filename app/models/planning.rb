class Planning < ActiveRecord::Base
  belongs_to :shop
  belongs_to :user
  has_many :shifts
  has_many :users, through: :shifts
end
