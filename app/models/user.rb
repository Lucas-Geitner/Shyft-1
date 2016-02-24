class User < ActiveRecord::Base
  has_many :memberships
  has_many :organisation_memberships
  has_many :plannings
  has_many :shifts
  has_many :abilities
  has_many :shops, through: :memberships
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :invitable, :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  accepts_nested_attributes_for :memberships, allow_destroy: true
end
