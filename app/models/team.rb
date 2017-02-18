class Team < ApplicationRecord
  has_many :quotes
  has_many :enrollments

  validates :name, presence: true, uniqueness: true

end
