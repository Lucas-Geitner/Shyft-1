class Group < ActiveRecord::Base
  belongs_to :organisation
  has_many :shops
end