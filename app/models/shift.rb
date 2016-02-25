class Shift < ActiveRecord::Base
  belongs_to :user
  belongs_to :poste
  belongs_to :planning
  has_many :employees, through: :postes, class_name:'Deal'
end
