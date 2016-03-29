class User < ActiveRecord::Base
  has_many :memberships, dependent: :destroy
  has_many :organisation_memberships, dependent: :destroy
  has_many :plannings
  has_many :shifts, dependent: :destroy
  has_many :abilities, dependent: :destroy
  has_many :postes, through: :abilities
  has_many :shops, through: :memberships
  has_many :primes
  # has_many :plannings, through: :shops

  devise :invitable, :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  accepts_nested_attributes_for :memberships, allow_destroy: true
  accepts_nested_attributes_for :abilities, allow_destroy: true

  has_attachment :contract

  validates :first_name, :last_name, presence: true

  def role
    self.memberships.first.role unless self.id.nil?
  end

  def name
    return self.first_name + " " + self.last_name
  end
end
