class Team < ApplicationRecord
  has_many :quotes, dependent: :destroy
  has_many :enrollments

  validates :name, presence: true, uniqueness: true

end
